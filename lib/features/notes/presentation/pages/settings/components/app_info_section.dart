import 'package:flutter/material.dart';
import 'package:note_taking_app/shared/constants/k.dart';
import '../../../../../../core/theme/theme_extensions.dart';

class AppInfoSection extends StatelessWidget {
  const AppInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(K.spacing24),
        child: Column(
          children: [
            const Icon(Icons.note_alt, size: K.iconSize48),
            K.gap12,
            Text(
              K.appName,
              style: context.titleStyle,
            ),
            K.gap8,
            Text(
              'Version ${K.appVersion}',
              style: context.captionStyle,
            ),
            K.gap12,
            Text(
              K.appDescription,
              style: context.captionStyle,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}