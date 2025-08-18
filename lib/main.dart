import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:appflowy_editor_sync_plugin/appflowy_editor_sync_plugin.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  // Initialize AppFlowy Editor Sync Plugin for CRDT synchronization
  await AppflowyEditorSyncUtilityFunctions.initAppFlowyEditorSync();

  // Initialize Supabase - you'll need to replace these with your actual Supabase credentials
  await Supabase.initialize(
    url: dotenv.env['YOUR_SUPABASE_URL'] ?? '',
    anonKey: dotenv.env['YOUR_SUPABASE_ANON_KEY'] ?? '',
  );

  driftRuntimeOptions.defaultSerializer = const ValueSerializer.defaults(
    serializeDateTimeValuesAsString: true,
  );

  // Get saved theme mode to avoid flickering on app start
  final savedThemeMode = await AdaptiveTheme.getThemeMode();

  runApp(ProviderScope(
    child: NotesApp(savedThemeMode: savedThemeMode),
  ));
}
