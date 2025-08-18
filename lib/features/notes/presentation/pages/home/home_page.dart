import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:note_taking_app/features/notes/presentation/dialogs/note_dialogs_service.dart';
import 'package:note_taking_app/shared/dialogs/shared_dialog_service.dart';

import '../../../../../shared/components/sync_status_indicator.dart';
import '../../../../../shared/constants/k.dart';
import 'components/dashboard_section.dart';
import 'components/home_drawer.dart';
import 'home_mixins.dart';

@RoutePage()
class HomePage extends HookConsumerWidget with HomeState, HomeEvent {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scaffoldKey = useState(GlobalKey<ScaffoldState>());

    return Scaffold(
      key: scaffoldKey.value,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => scaffoldKey.value.currentState?.openDrawer(),
        ),
        title: const Text(K.notes),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => navigateToSettings(context),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Container(
            padding: const EdgeInsets.all(K.spacing16),
            child: SyncStatusIndicator(
              onTap: () => SharedDialogService.showSyncStatusDialog(
                context: context,
                syncStatus: syncStatus(ref),
                isOffline: isOffline(ref),
                onForceSync: () => forceSync(ref),
                onSignIn: () => navigateToLogin(context),
              ),
            ),
          ),
        ),
      ),
      drawer: HomeDrawer(),
      body: DashboardSection(),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            NoteDialogsService.showNoteCreationSheet(context, null),
        child: const Icon(Icons.add),
      ),
    );
  }
}
