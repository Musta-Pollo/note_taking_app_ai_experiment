import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_taking_app/app/router/app_router.dart';
import 'package:note_taking_app/features/notes/presentation/pages/home/components/category_card.dart';
import 'package:note_taking_app/features/notes/presentation/pages/home/components/empty_categories.dart';
import 'package:note_taking_app/features/notes/presentation/pages/home/home_mixins.dart';

import '../../../../../../../core/theme/theme_extensions.dart';
import '../../../../../../../shared/constants/k.dart';

class CategoriesSection extends ConsumerWidget with HomeState {
  const CategoriesSection({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final category = categories(ref);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          K.categories,
          style: context.titleStyle,
        ),
        K.gap16,
        category.when(
          data: (categoryList) => categoryList.isEmpty
              ? EmptyCategories()
              : Column(
                  children: categoryList
                      .map((category) => CategoryCard(
                            category: category,
                            onTap: () => context.pushRoute(
                              CategoryRoute(categoryId: category.id),
                            ),
                          ))
                      .toList(),
                ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => EmptyCategories(),
        ),
      ],
    );
  }
}
