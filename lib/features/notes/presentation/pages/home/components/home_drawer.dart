import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_taking_app/app/router/app_router.dart';
import 'package:note_taking_app/features/notes/presentation/dialogs/note_dialogs_service.dart';
import 'package:note_taking_app/features/notes/presentation/pages/home/home_mixins.dart';

class HomeDrawer extends ConsumerWidget with HomeEvent, HomeState {
  const HomeDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoggedIn = !isOffline(ref);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isLoggedIn ? 'Welcome Back!' : 'Notes App',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  isLoggedIn ? 'Signed in' : 'Working offline',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              context.maybePop();
              context.pushRoute(HomeRoute());
            },
          ),
          ListTile(
            leading: const Icon(Icons.search),
            title: const Text('Search'),
            onTap: () => onSearchTap(context),
          ),
          ListTile(
            leading: const Icon(Icons.folder),
            title: const Text('Categories'),
            onTap: () {
              context.maybePop();
              NoteDialogsService.showCategoriesBottomSheet(context: context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              context.maybePop();
              navigateToSettings(context);
            },
          ),
          const Divider(),
          if (isLoggedIn)
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Sign Out'),
              onTap: () {
                context.maybePop();
                signOut(ref);
              },
            )
          else
            ListTile(
              leading: const Icon(Icons.login),
              title: const Text('Sign In'),
              onTap: () {
                context.maybePop();
                navigateToLogin(context);
              },
            ),
        ],
      ),
    );
  }
}
