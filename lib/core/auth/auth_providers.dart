import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_providers.g.dart';

/// Current authenticated user provider
@riverpod
AsyncValue<User?> authUser(Ref ref) {
  // Watch the auth service which properly listens to state changes
  return ref.watch(authServiceProvider);
}

/// Auth state changes stream provider  
@riverpod
Stream<AuthState> authStateChanges(Ref ref) {
  final supabase = Supabase.instance.client;
  return supabase.auth.onAuthStateChange;
}

/// Sign in with email and password
@riverpod
class AuthService extends _$AuthService {
  @override
  AsyncValue<User?> build() {
    // Listen to auth state changes
    ref.listen(authStateChangesProvider, (previous, next) {
      next.when(
        data: (authState) {
          state = AsyncValue.data(authState.session?.user);
        },
        error: (error, stack) {
          state = AsyncValue.error(error, stack);
        },
        loading: () {
          state = const AsyncValue.loading();
        },
      );
    });
    
    return AsyncValue.data(Supabase.instance.client.auth.currentUser);
  }

  /// Sign in with email and password
  Future<void> signIn(String email, String password) async {
    try {
      state = const AsyncValue.loading();
      
      final response = await Supabase.instance.client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      
      state = AsyncValue.data(response.user);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  /// Sign up with email and password
  Future<void> signUp(String email, String password) async {
    try {
      state = const AsyncValue.loading();
      
      final response = await Supabase.instance.client.auth.signUp(
        email: email,
        password: password,
      );
      
      state = AsyncValue.data(response.user);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  /// Sign out
  Future<void> signOut() async {
    try {
      await Supabase.instance.client.auth.signOut();
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}