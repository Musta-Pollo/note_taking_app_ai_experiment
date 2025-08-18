import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_taking_app/core/database/tables/notes_table.dart';
import 'package:note_taking_app/shared/components/app_popup_menu.dart';
import 'package:note_taking_app/shared/enums/menu_actions.dart';

import '../category_mixins.dart';

/// Category header component with title and sort dropdown
class CategoryHeader extends ConsumerWidget with CategoryState {
  const CategoryHeader({
    super.key,
    required this.categoryId,
    required this.sortType,
    required this.onSortChanged,
  });

  final String categoryId;
  final SortType sortType;
  final ValueChanged<SortType> onSortChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoryName = getCategoryName(ref, categoryId);

    return AppBar(
      title: Text(categoryName),
      actions: [
        SortPopupMenu(
          actions: SortMenuAction.values,
          onSelected: (onSelected) {
            onSortChanged(onSelected.sortType);
          },
          enabled: true,
        ),
      ],
    );
  }
}
