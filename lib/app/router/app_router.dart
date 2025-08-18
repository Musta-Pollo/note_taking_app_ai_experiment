import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:note_taking_app/features/auth/presentation/pages/login/login_page.dart';
import 'package:note_taking_app/features/notes/domain/entities/note_entity.dart';
import 'package:note_taking_app/features/notes/presentation/pages/categories/category_page.dart';
import 'package:note_taking_app/features/notes/presentation/pages/home/home_page.dart';
import 'package:note_taking_app/features/notes/presentation/pages/note/note_page.dart';
import 'package:note_taking_app/features/notes/presentation/pages/note_editor/note_editor_page.dart';
import 'package:note_taking_app/features/notes/presentation/pages/search/search_page.dart';
import 'package:note_taking_app/features/notes/presentation/pages/settings/settings_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => RouteType.material();

  @override
  List<AutoRoute> get routes => [
        // Login route
        AutoRoute(
          page: LoginRoute.page,
          path: '/login',
          initial: false,
        ),

        // Home route (protected)
        AutoRoute(
          page: HomeRoute.page,
          path: '/home',
          initial: true,
        ),

        // Note editor route
        AutoRoute(
          page: NoteEditorRoute.page,
          path: '/note/:noteId',
        ),

        // Settings route
        AutoRoute(
          page: SettingsRoute.page,
          path: '/settings',
        ),

        // Fallback route
        AutoRoute(
          path: '*',
          page: NotFoundRoute.page,
        ),
        AutoRoute(page: SearchRoute.page),
        AutoRoute(page: CategoryRoute.page),
        AutoRoute(page: NoteRoute.page),
      ];
}

// Placeholder - actual implementation is in separate file

// Not Found Page
@RoutePage()
class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page Not Found')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64),
            SizedBox(height: 16),
            Text(
              '404 - Page Not Found',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('The requested page could not be found.'),
          ],
        ),
      ),
    );
  }
}
