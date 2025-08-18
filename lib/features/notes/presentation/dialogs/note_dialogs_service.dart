import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_taking_app/features/notes/presentation/dialogs/add_category_dialog.dart';
import 'package:note_taking_app/features/notes/presentation/dialogs/categories_bottom_sheet.dart';
import 'package:note_taking_app/features/notes/presentation/dialogs/create_rich_note_sheet.dart';
import 'package:note_taking_app/features/notes/presentation/dialogs/create_simple_note_sheet.dart';
import 'package:note_taking_app/features/notes/presentation/dialogs/edit_category_dialog.dart';
import 'package:note_taking_app/features/notes/presentation/pages/categories/category_mixins.dart'
    hide CreateRichNoteSheet, CreateSimpleNoteSheet;
import 'package:note_taking_app/features/notes/presentation/providers/categories_providers.dart';
import 'package:note_taking_app/shared/constants/k.dart';
import 'package:note_taking_app/shared/dialogs/shared_dialog_service.dart';

import '../../domain/entities/category_entity.dart';

/// Centralized service for all note and category related dialogs
class NoteDialogsService {
  NoteDialogsService(this.ref);

  final Ref ref;

  static void showCategoriesBottomSheet({
    required BuildContext context,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => CategoriesBottomSheet(),
    );
  }

  static void showAddCategoryDialog({
    required BuildContext context,
  }) {
    showDialog(
      context: context,
      builder: (context) => AddCategoryDialog(),
    );
  }

  static void showEditCategoryDialog({
    required BuildContext context,
    required CategoryEntity category,
  }) {
    showDialog(
      context: context,
      builder: (context) => EditCategoryDialog(
        initialCategory: category,
      ),
    );
  }

  void showDeleteCategoryDialog({
    required BuildContext context,
    required CategoryEntity category,
  }) async {
    final res = await SharedDialogService.showConfirmationDialog(
      context: context,
      title: 'Delete Category',
      content:
          'Are you sure you want to delete this category? This will also delete all notes in this category.',
      confirmLabel: 'Delete',
      cancelLabel: 'Cancel',
    );
    if (res == null) return;
    if (res == true) {
      ref.read(categoriesNotifierProvider.notifier).deleteCategory(category.id);
    }
  }

  static void showCreateSimpleNoteDialog({
    required BuildContext context,
    required String? initialCategoryId,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(K.cornerRadius20)),
      ),
      builder: (context) => CreateSimpleNoteSheet(
        initialCategoryId: initialCategoryId,
      ),
    );
  }

  static void showCreateRichNoteSheet({
    required BuildContext context,
    String? initialCategoryId,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(K.cornerRadius20)),
      ),
      builder: (context) => CreateRichNoteSheet(
        initialCategoryId: initialCategoryId,
      ),
    );
  }

  // ==================== NOTE CREATION BOTTOM SHEET WIDGETS ====================

  static void showNoteCreationSheet(
    BuildContext context,
    String? categoryId,
  ) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => NoteCreationSheet(
        categoryId: categoryId,
      ),
    );
  }

  // ==================== OTHER DIALOGS ====================

  static void showSearchTipsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Search Tips'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('💡 Search Tips:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('• Type keywords to search note content'),
            Text('• Search is case-insensitive'),
            Text('• Results are ranked by relevance'),
            Text('• Use specific terms for better results'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => context.maybePop(),
            child: const Text('Got it!'),
          ),
        ],
      ),
    );
  }
}
