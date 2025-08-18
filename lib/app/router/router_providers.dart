import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'app_router.dart';

part 'router_providers.g.dart';

/// App router provider
@riverpod
AppRouter appRouter(Ref ref) {
  return AppRouter();
}

/// Navigation helper provider
@riverpod
class NavigationHelper extends _$NavigationHelper {
  @override
  void build() {
    // No initial state needed
  }

  /// Navigate to login page
  void goToLogin() {
    ref.read(appRouterProvider).replaceAll([LoginRoute()]);
  }

  /// Navigate to home page
  void goToHome() {
    ref.read(appRouterProvider).replaceAll([HomeRoute()]);
  }

  /// Navigate to note editor
  void goToNoteEditor(String noteId) {
    ref.read(appRouterProvider).push(NoteEditorRoute(noteId: noteId));
  }

  /// Navigate to settings
  void goToSettings() {
    ref.read(appRouterProvider).push(SettingsRoute());
  }

  /// Go back
  void goBack() {
    ref.read(appRouterProvider).back();
  }

  /// Check if can go back
  bool canGoBack() {
    return ref.read(appRouterProvider).canPop();
  }
}
