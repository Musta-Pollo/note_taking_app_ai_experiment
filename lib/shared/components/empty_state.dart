import 'package:flutter/material.dart';
import '../constants/k.dart';
import '../../core/theme/theme_extensions.dart';

/// A reusable empty state widget
class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.title,
    required this.message,
    required this.icon,
    this.actionLabel,
    this.onAction,
  });

  final String title;
  final String message;
  final IconData icon;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(K.spacing48),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: K.iconSize64,
              color: context.colors.onSurface50,
            ),
            K.gap16,
            Text(
              title,
              style: context.titleStyle,
              textAlign: TextAlign.center,
            ),
            K.gap8,
            Text(
              message,
              style: context.subtitleStyle,
              textAlign: TextAlign.center,
            ),
            if (actionLabel != null && onAction != null) ...[
              K.gap16,
              ElevatedButton(
                onPressed: onAction,
                child: Text(actionLabel!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}