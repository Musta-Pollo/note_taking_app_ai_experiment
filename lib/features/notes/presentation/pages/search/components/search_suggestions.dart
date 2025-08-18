import 'package:flutter/material.dart';
import '../../../../../../shared/constants/k.dart';
import '../../../../../../core/theme/theme_extensions.dart';

class SearchSuggestions extends StatelessWidget {
  const SearchSuggestions({
    super.key,
    required this.tips,
    required this.buildSearchTip,
  });

  final List<String> tips;
  final Widget Function(String, BuildContext) buildSearchTip;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search,
            size: K.iconSize64,
            color: context.colors.onSurface50,
          ),
          K.gap16,
          Text(
            'Search Your Notes',
            style: context.titleStyle,
          ),
          K.gap8,
          Text(
            'Enter keywords to find notes quickly',
            style: context.subtitleStyle,
            textAlign: TextAlign.center,
          ),
          K.gap32,
          // Search tips
          Card(
            margin: const EdgeInsets.symmetric(horizontal: K.spacing32),
            child: Padding(
              padding: const EdgeInsets.all(K.spacing16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Search Tips:',
                    style: context.bodyStyle?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  K.gap8,
                  ...tips.map((tip) => buildSearchTip(tip, context)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}