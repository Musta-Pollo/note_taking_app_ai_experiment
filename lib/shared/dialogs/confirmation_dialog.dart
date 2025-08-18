import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:note_taking_app/core/theme/context_extension.dart';

import '../constants/k.dart';

/// A reusable confirmation dialog widget
class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({
    super.key,
    required this.title,
    required this.content,
    this.confirmLabel = K.delete,
    this.cancelLabel = K.cancel,
    this.isDestructive = false,
  });

  final String title;
  final String content;
  final String confirmLabel;
  final String cancelLabel;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () => context.maybePop(false),
          child: Text(cancelLabel),
        ),
        TextButton(
          onPressed: () => context.maybePop(true),
          style: isDestructive
              ? TextButton.styleFrom(
                  foregroundColor: context.colorScheme.error,
                )
              : null,
          child: Text(confirmLabel),
        ),
      ],
    );
  }
}
