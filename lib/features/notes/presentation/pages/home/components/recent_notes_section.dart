import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_taking_app/app/router/app_router.dart';
import 'package:note_taking_app/features/notes/presentation/pages/home/components/empty_notes.dart';
import 'package:note_taking_app/features/notes/presentation/pages/home/home_mixins.dart';

import '../../../../../../../core/theme/theme_extensions.dart';
import '../../../../../../../shared/constants/k.dart';
import '../../../../domain/entities/note_entity.dart';
import '../../../components/note_card_widget.dart';

class RecentNotesSection extends ConsumerWidget with HomeState {
  const RecentNotesSection({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recNotes = recentNotes(ref);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          K.recentNotes,
          style: context.titleStyle,
        ),
        K.gap16,
        recNotes.when(
          data: (noteList) => noteList.isEmpty
              ? EmptyNotes()
              : Column(
                  children: noteList
                      .take(K.recentNotesLimit)
                      .map((note) => NoteCardWidget(
                            note: note,
                            showCategory: true,
                            onTap: () => context.pushRoute(
                              NoteRoute(note: note),
                            ),
                          ))
                      .toList(),
                ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => EmptyNotes(),
        ),
      ],
    );
  }
}
