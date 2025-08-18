import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_taking_app/app/router/app_router.dart';
import 'package:note_taking_app/core/theme/context_extension.dart';

import '../../../../../../shared/constants/k.dart';
import 'categories_section.dart';
import 'recent_notes_section.dart';

class DashboardSection extends ConsumerWidget {
  const DashboardSection({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(K.spacing16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search bar
          Container(
            decoration: BoxDecoration(
              color: context.colorScheme.surface,
              borderRadius: K.borderRadius12,
              border: Border.all(
                color: Theme.of(context)
                    .colorScheme
                    .outline
                    .withValues(alpha: 0.5),
              ),
            ),
            child: TextField(
              decoration: const InputDecoration(
                hintText: K.searchNotes,
                prefixIcon: Icon(Icons.search),
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(K.spacing16),
              ),
              onTap: () => context.pushRoute(SearchRoute()),
              readOnly: true,
            ),
          ),
          K.gap24,
          // Categories section
          CategoriesSection(),
          K.gap24,
          // Recent notes section
          RecentNotesSection(),
        ],
      ),
    );
  }
}
