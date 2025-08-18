import 'package:flutter/material.dart';
import '../constants/k.dart';
import '../../core/theme/theme_extensions.dart';

/// A reusable error state widget
class ErrorState extends StatelessWidget {
  const ErrorState({
    super.key,
    required this.error,
    this.title = K.error,
    this.onRetry,
    this.retryLabel = K.tryAgain,
  });

  final String title;
  final Object error;
  final VoidCallback? onRetry;
  final String retryLabel;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(K.spacing24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: K.iconSize64,
              color: context.colors.error,
            ),
            K.gap24,
            Text(
              title,
              style: context.titleStyle,
              textAlign: TextAlign.center,
            ),
            K.gap12,
            Text(
              error.toString(),
              style: context.captionStyle,
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              K.gap24,
              ElevatedButton(
                onPressed: onRetry,
                child: Text(retryLabel),
              ),
            ],
          ],
        ),
      ),
    );
  }
}