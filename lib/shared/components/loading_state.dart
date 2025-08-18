import 'package:flutter/material.dart';
import '../constants/k.dart';
import '../../core/theme/theme_extensions.dart';

/// A reusable loading state widget
class LoadingState extends StatelessWidget {
  const LoadingState({
    super.key,
    this.message = K.loading,
    this.showMessage = true,
  });

  final String message;
  final bool showMessage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          if (showMessage) ...[
            K.gap24,
            Text(
              message,
              style: context.bodyStyle,
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}