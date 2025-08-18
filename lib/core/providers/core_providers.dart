import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../database/app_database.dart';
import '../auth/auth_providers.dart';
import '../sync/sync_manager.dart';

part 'core_providers.g.dart';

/// Database provider - single instance across the app
@riverpod
AppDatabase database(Ref ref) {
  return AppDatabase();
}

/// Supabase client provider
@riverpod
SupabaseClient supabase(Ref ref) {
  return Supabase.instance.client;
}

/// Current user ID provider
@riverpod
String? currentUserId(Ref ref) {
  return ref.watch(authUserProvider).value?.id;
}

/// Sync class instance
@riverpod
SyncClass syncClass(Ref ref) {
  return const SyncClass();
}