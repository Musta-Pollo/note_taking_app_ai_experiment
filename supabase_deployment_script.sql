-- =====================================================
-- SUPABASE DEPLOYMENT SCRIPT FOR NOTES APP
-- =====================================================
-- Execute this script in your Supabase SQL Editor
-- Run each section step by step for better error tracking

-- =====================================================
-- STEP 1: CREATE DATABASE TABLES
-- =====================================================

-- Create Categories Table
CREATE TABLE IF NOT EXISTS public.categories (
    id UUID NOT NULL,
    name TEXT NOT NULL,
    user_id UUID NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    deleted_at TIMESTAMPTZ,
    server_created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    server_updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    instance_id UUID
);

-- Create Notes Table
CREATE TABLE IF NOT EXISTS public.notes (
    id UUID NOT NULL,
    content TEXT NOT NULL,
    category_id UUID NOT NULL,
    note_type INTEGER NOT NULL,
    user_id UUID NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    deleted_at TIMESTAMPTZ,
    server_created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    server_updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    instance_id UUID
);

-- Create Note Editor Data Table
CREATE TABLE IF NOT EXISTS public.note_editor_data (
    id UUID NOT NULL,
    note_id UUID NOT NULL,
    data_b64 TEXT NOT NULL,
    user_id UUID NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    deleted_at TIMESTAMPTZ,
    server_created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    server_updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    instance_id UUID
);

-- =====================================================
-- STEP 2: ADD PRIMARY KEYS AND CONSTRAINTS
-- =====================================================

-- Add Primary Keys (only if they don't exist)
DO $$ 
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'categories_pkey') THEN
        ALTER TABLE public.categories ADD CONSTRAINT categories_pkey PRIMARY KEY (id);
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'notes_pkey') THEN
        ALTER TABLE public.notes ADD CONSTRAINT notes_pkey PRIMARY KEY (id);
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'note_editor_data_pkey') THEN
        ALTER TABLE public.note_editor_data ADD CONSTRAINT note_editor_data_pkey PRIMARY KEY (id);
    END IF;
END $$;

-- Add Foreign Key Constraints (only if they don't exist)
DO $$ 
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'notes_category_id_fkey') THEN
        ALTER TABLE public.notes ADD CONSTRAINT notes_category_id_fkey
            FOREIGN KEY (category_id) REFERENCES public.categories(id) ON DELETE CASCADE;
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'note_editor_data_note_id_fkey') THEN
        ALTER TABLE public.note_editor_data ADD CONSTRAINT note_editor_data_note_id_fkey
            FOREIGN KEY (note_id) REFERENCES public.notes(id) ON DELETE CASCADE;
    END IF;
END $$;

-- =====================================================
-- STEP 3: ENABLE ROW LEVEL SECURITY
-- =====================================================

-- Enable RLS on all tables
ALTER TABLE public.categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.notes ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.note_editor_data ENABLE ROW LEVEL SECURITY;

-- Drop existing policies if they exist and create new ones
DROP POLICY IF EXISTS "categories_rls" ON public.categories;
CREATE POLICY "categories_rls" ON public.categories 
    FOR ALL 
    TO authenticated 
    USING ((auth.uid() = user_id)) 
    WITH CHECK ((auth.uid() = user_id));

DROP POLICY IF EXISTS "notes_rls" ON public.notes;
CREATE POLICY "notes_rls" ON public.notes 
    FOR ALL 
    TO authenticated 
    USING ((auth.uid() = user_id)) 
    WITH CHECK ((auth.uid() = user_id));

DROP POLICY IF EXISTS "note_editor_data_rls" ON public.note_editor_data;
CREATE POLICY "note_editor_data_rls" ON public.note_editor_data 
    FOR ALL 
    TO authenticated 
    USING ((auth.uid() = user_id)) 
    WITH CHECK ((auth.uid() = user_id));

-- =====================================================
-- STEP 4: CREATE PERFORMANCE INDEXES
-- =====================================================

-- Create indexes for better performance (only if they don't exist)
CREATE INDEX IF NOT EXISTS idx_categories_user_id ON public.categories(user_id);
CREATE INDEX IF NOT EXISTS idx_categories_deleted_at ON public.categories(deleted_at);
CREATE INDEX IF NOT EXISTS idx_categories_server_created_at ON public.categories(server_created_at);
CREATE INDEX IF NOT EXISTS idx_categories_server_updated_at ON public.categories(server_updated_at);

CREATE INDEX IF NOT EXISTS idx_notes_user_id ON public.notes(user_id);
CREATE INDEX IF NOT EXISTS idx_notes_category_id ON public.notes(category_id);
CREATE INDEX IF NOT EXISTS idx_notes_deleted_at ON public.notes(deleted_at);
CREATE INDEX IF NOT EXISTS idx_notes_server_created_at ON public.notes(server_created_at);
CREATE INDEX IF NOT EXISTS idx_notes_server_updated_at ON public.notes(server_updated_at);

CREATE INDEX IF NOT EXISTS idx_note_editor_data_user_id ON public.note_editor_data(user_id);
CREATE INDEX IF NOT EXISTS idx_note_editor_data_note_id ON public.note_editor_data(note_id);
CREATE INDEX IF NOT EXISTS idx_note_editor_data_deleted_at ON public.note_editor_data(deleted_at);
CREATE INDEX IF NOT EXISTS idx_note_editor_data_server_created_at ON public.note_editor_data(server_created_at);
CREATE INDEX IF NOT EXISTS idx_note_editor_data_server_updated_at ON public.note_editor_data(server_updated_at);

-- =====================================================
-- STEP 5: CREATE FUNCS SCHEMA AND HELPER FUNCTIONS
-- =====================================================

-- Create the funcs schema
CREATE SCHEMA IF NOT EXISTS funcs;

-- Helper function to construct SQL for collection operations
CREATE OR REPLACE FUNCTION construct_sql_for_collection(collection TEXT, cols TEXT, excl TEXT)
RETURNS TEXT AS $$
BEGIN
    RETURN format($f$
        INSERT INTO %1$s (user_id, server_created_at, %2$s)
        SELECT $1, $2, %2$s
        FROM jsonb_populate_recordset(null::%1$s, COALESCE((($3)->'%1$s')->'created', '[]') || COALESCE((($3)->'%1$s')->'updated', '[]'))
        ON CONFLICT (id) DO UPDATE SET (server_updated_at, %2$s) = ($2, %3$s)
    $f$, collection, cols, excl);
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Function to retrieve columns and exclusions for the insert/update operation
CREATE OR REPLACE FUNCTION get_columns_and_exclusions(collection TEXT)
RETURNS TABLE(cols TEXT, excl TEXT) AS $$
BEGIN
    RETURN QUERY
    SELECT
        string_agg(quote_ident(attname), ',' ORDER BY attnum) AS cols,
        string_agg(format('COALESCE(excluded.%1$s, %2$I.%1$s)', attname, split_part(collection, '.', 2)), ',' ORDER BY attnum) AS excl
    FROM pg_attribute att
    WHERE attrelid = to_regclass(collection)
    AND attnum > 0
    AND attname NOT IN ('user_id', 'server_created_at', 'server_updated_at', 'deleted_at')
    AND NOT attisdropped;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Function to construct insert/update SQL statements
CREATE OR REPLACE FUNCTION construct_insert_update_sql(_updated_collections TEXT[], _changes JSONB)
RETURNS TEXT[] AS $$
DECLARE
    _sql_array TEXT[] := ARRAY[]::TEXT[];
    cols TEXT;
    excl TEXT;
    collection TEXT;
    sql_statement TEXT;
BEGIN
    FOREACH collection IN ARRAY _updated_collections
    LOOP
        -- Get columns and exclusions for the collection
        SELECT gc.cols, gc.excl INTO cols, excl
        FROM get_columns_and_exclusions(collection) AS gc;

        -- Construct SQL for the collection
        sql_statement := construct_sql_for_collection(collection, cols, excl);
        
        -- Add to array of SQL statements
        _sql_array := array_append(_sql_array, sql_statement);
    END LOOP;

    RETURN _sql_array;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- =====================================================
-- STEP 6: CREATE PULL CHANGES FUNCTIONS
-- =====================================================

-- Function to get created records since last sync
CREATE OR REPLACE FUNCTION funcs.pull_updates_created (
  _user_id UUID,
  _table_name TEXT,
  _last_pulled_at TIMESTAMP WITH TIME ZONE
) RETURNS jsonb AS $$
DECLARE
    _result jsonb;
    _schema_name TEXT;
    _table TEXT;
BEGIN
    -- Split the fully qualified table name into schema and table parts
    _schema_name := split_part(_table_name, '.', 1);
    _table := split_part(_table_name, '.', 2);

    -- Execute the query with schema and table name
    EXECUTE format(
        'SELECT jsonb_agg(src ORDER BY server_created_at, id::text) FROM %I.%I src WHERE src.user_id = $1 AND src.deleted_at IS NULL AND src.server_created_at >= $2',
        _schema_name, _table
    ) INTO _result USING _user_id, _last_pulled_at;

    RETURN COALESCE(_result, '[]'::jsonb);
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Function to get updated records since last sync
CREATE OR REPLACE FUNCTION funcs.pull_updates_updated (
  _user_id UUID,
  _table_name TEXT,
  _last_pulled_at TIMESTAMP WITH TIME ZONE
) RETURNS jsonb AS $$
DECLARE
    _result jsonb;
    _schema_name TEXT;
    _table TEXT;
BEGIN
    -- Split the fully qualified table name into schema and table parts
    _schema_name := split_part(_table_name, '.', 1);
    _table := split_part(_table_name, '.', 2);

    -- Execute the query with schema and table name
    EXECUTE format(
        'SELECT jsonb_agg(src ORDER BY server_updated_at, id::text) FROM %1$s src WHERE src.user_id = $1 AND src.deleted_at IS NULL AND src.server_updated_at >= $2',
        _table_name
    ) INTO _result USING _user_id, _last_pulled_at;

    RETURN COALESCE(_result, '[]'::jsonb);
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Function to get deleted records since last sync
CREATE OR REPLACE FUNCTION funcs.pull_updates_deleted (
  _user_id UUID,
  _table_name TEXT,
  _last_pulled_at TIMESTAMP WITH TIME ZONE
) RETURNS jsonb AS $$
DECLARE
    _result jsonb;
    _schema_name TEXT;
    _table TEXT;
BEGIN
    -- Split the fully qualified table name into schema and table parts
    _schema_name := split_part(_table_name, '.', 1);
    _table := split_part(_table_name, '.', 2);

    -- Execute the query with schema and table name, but selecting only the IDs
    EXECUTE format(
        'SELECT jsonb_agg(src.id ORDER BY src.deleted_at, src.id::text) FROM %I.%I src WHERE src.user_id = $1 AND src.deleted_at IS NOT NULL AND src.deleted_at >= $2',
        _schema_name, _table
    ) INTO _result USING _user_id, _last_pulled_at;

    RETURN COALESCE(_result, '[]'::jsonb);
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Main pull changes function
CREATE OR REPLACE FUNCTION pull_changes (
  collections TEXT[],
  last_pulled_at TIMESTAMP WITH TIME ZONE
) RETURNS jsonb AS $$
DECLARE
    _result jsonb;
    _user_id uuid;
BEGIN
    SELECT auth.uid() into _user_id;
    RETURN jsonb_build_object(
        'timestamp', trunc(EXTRACT(epoch FROM now() AT TIME ZONE 'UTC') * 1000),
        'changes', jsonb_object_agg(
            col, jsonb_build_object(
                'created', funcs.pull_updates_created(_user_id, col, last_pulled_at),
                'updated', funcs.pull_updates_updated(_user_id, col, last_pulled_at),
                'deleted', funcs.pull_updates_deleted(_user_id, col, last_pulled_at)
            )
        )
    )::jsonb
    FROM UNNEST(collections) AS col;
END; 
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- =====================================================
-- STEP 7: CREATE PUSH CHANGES FUNCTION
-- =====================================================

CREATE OR REPLACE FUNCTION push_changes (
    _changes JSONB,
    last_pulled_at TIMESTAMP WITH TIME ZONE
) RETURNS TIMESTAMP WITH TIME ZONE AS $$
DECLARE
    _updated_collections TEXT[];
    _purgatory BOOLEAN;
    _user_id UUID;
    _now_utc TIMESTAMP WITH TIME ZONE;
    _sql_array TEXT[];
    _sql TEXT;
    _stmt TEXT;
BEGIN
    -- GET USERID and current time
    SELECT auth.uid() INTO _user_id;
    _now_utc := NOW();

    -- Look in all collections that include at least one created or updated element
    SELECT array_agg(key)
    INTO _updated_collections
    FROM jsonb_each(_changes)
    WHERE (
        -- Check if the 'created' array is not empty
        (jsonb_array_length(COALESCE(value->'created', '[]')) > 0) 
        -- Check if the 'updated' array is not empty
        OR (jsonb_array_length(COALESCE(value->'updated', '[]')) > 0)
    )
    AND to_regclass(format('%I.%I', split_part(key, '.', 1), split_part(key, '.', 2))) IS NOT NULL;

    IF _updated_collections IS NOT NULL AND array_length(_updated_collections, 1) > 0 THEN
        -- Only perform the checks if last_pulled_at is NOT NULL
        IF last_pulled_at IS NOT NULL THEN
            -- Prevent updates or inserts out of sequence
            EXECUTE (
                'SELECT ' || string_agg(format($f$
                    EXISTS (
                        SELECT 1 FROM %I.%I
                        WHERE deleted_at IS NULL
                        AND server_updated_at > $2
                    )$f$, split_part(col, '.', 1), split_part(col, '.', 2)), ' OR ')
            )
            FROM UNNEST(_updated_collections) col
            USING _user_id, last_pulled_at INTO _purgatory;

            IF _purgatory THEN
                RAISE EXCEPTION 'push_changes: Record was updated remotely between pull and push';
            END IF;

            -- Prevent creation out of sequence
            EXECUTE (
                'SELECT ' || string_agg(format($f$
                    EXISTS (
                        SELECT 1 FROM %I.%I
                        WHERE deleted_at IS NULL
                        AND server_created_at > $2
                    )$f$, split_part(col, '.', 1), split_part(col, '.', 2)), ' OR ')
            )
            FROM UNNEST(_updated_collections) col
            USING _user_id, last_pulled_at INTO _purgatory;

            IF _purgatory THEN
                RAISE EXCEPTION 'push_changes: Record was created remotely between pull and push';
            END IF;
        END IF;

        -- Get array of SQL statements
        _sql_array := construct_insert_update_sql(_updated_collections, _changes);

        -- Execute each SQL statement separately
        FOREACH _stmt IN ARRAY _sql_array
        LOOP
            -- Execute the statement
            EXECUTE _stmt USING _user_id, _now_utc, _changes;
        END LOOP;
    END IF;

    -- Handle deletes
    SELECT array_agg(key ORDER BY key)
    INTO _updated_collections
    FROM jsonb_each(_changes)
    WHERE COALESCE(value->'deleted', '[]') <> '[]'
    AND to_regclass(format('%I.%I', split_part(key, '.', 1), split_part(key, '.', 2))) IS NOT NULL;

    IF _updated_collections IS NOT NULL AND array_length(_updated_collections, 1) > 0 THEN
        -- Construct delete statements as an array
        _sql_array := (
            SELECT array_agg(
                format($f$
                    UPDATE %I.%I
                    SET deleted_at = $1
                    WHERE id::text = ANY(
                        SELECT jsonb_array_elements_text((($2)->%L)->'deleted')
                    )
                    AND deleted_at IS NULL
                $f$, split_part(collection, '.', 1), split_part(collection, '.', 2), collection)
            )
            FROM UNNEST(_updated_collections) collection
        );

        -- Execute each delete statement
        FOREACH _sql IN ARRAY _sql_array
        LOOP
            EXECUTE _sql USING _now_utc, _changes;
        END LOOP;
    END IF;

    RETURN _now_utc;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- =====================================================
-- STEP 8: GRANT PERMISSIONS
-- =====================================================

-- Grant execute permissions to authenticated users
GRANT EXECUTE ON FUNCTION pull_changes(TEXT[], TIMESTAMP WITH TIME ZONE) TO authenticated;
GRANT EXECUTE ON FUNCTION push_changes(JSONB, TIMESTAMP WITH TIME ZONE) TO authenticated;
GRANT EXECUTE ON FUNCTION funcs.pull_updates_created(UUID, TEXT, TIMESTAMP WITH TIME ZONE) TO authenticated;
GRANT EXECUTE ON FUNCTION funcs.pull_updates_updated(UUID, TEXT, TIMESTAMP WITH TIME ZONE) TO authenticated;  
GRANT EXECUTE ON FUNCTION funcs.pull_updates_deleted(UUID, TEXT, TIMESTAMP WITH TIME ZONE) TO authenticated;
GRANT EXECUTE ON FUNCTION construct_sql_for_collection(TEXT, TEXT, TEXT) TO authenticated;
GRANT EXECUTE ON FUNCTION get_columns_and_exclusions(TEXT) TO authenticated;
GRANT EXECUTE ON FUNCTION construct_insert_update_sql(TEXT[], JSONB) TO authenticated;

-- Grant usage on funcs schema
GRANT USAGE ON SCHEMA funcs TO authenticated;

-- =====================================================
-- STEP 9: VERIFICATION QUERIES
-- =====================================================

-- Verify tables were created
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public' 
AND table_name IN ('categories', 'notes', 'note_editor_data')
ORDER BY table_name;

-- Verify functions were created
SELECT routine_name 
FROM information_schema.routines 
WHERE routine_schema = 'public' 
AND routine_name IN ('pull_changes', 'push_changes')
ORDER BY routine_name;

-- Verify funcs schema functions
SELECT routine_name 
FROM information_schema.routines 
WHERE routine_schema = 'funcs'
ORDER BY routine_name;

-- =====================================================
-- DEPLOYMENT COMPLETE
-- =====================================================
-- All tables, functions, and permissions have been set up.
-- Your Flutter app can now use the sync functionality.
-- =====================================================