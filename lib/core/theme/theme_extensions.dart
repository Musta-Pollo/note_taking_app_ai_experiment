import 'package:flutter/material.dart';
import 'package:note_taking_app/core/theme/context_extension.dart';

import '../../shared/constants/k.dart';

/// Color scheme extensions for consistent color usage
extension AppColorScheme on ColorScheme {
  /// On-surface color variations
  Color get onSurface70 => onSurface.withValues(alpha: K.opacity70);
  Color get onSurface50 => onSurface.withValues(alpha: K.opacity50);
  Color get onSurface30 => onSurface.withValues(alpha: K.opacity30);
}

/// Theme context extensions for easy access
extension AppTheme on BuildContext {
  /// Quick access to color scheme
  ColorScheme get colors => theme.colorScheme;

  /// Quick access to text theme
  TextTheme get textStyles => theme.textTheme;

  /// Common text styles with theme colors applied
  TextStyle? get titleStyle => textStyles.titleLarge
      ?.copyWith(fontWeight: FontWeight.bold, color: colors.onSurface);
  TextStyle? get subtitleStyle =>
      textStyles.bodyMedium?.copyWith(color: colors.onSurface70);
  TextStyle? get bodyStyle =>
      textStyles.bodyMedium?.copyWith(color: colors.onSurface);
  TextStyle? get captionStyle =>
      textStyles.bodySmall?.copyWith(color: colors.onSurface50);
}

/// Card and container styling extensions
extension AppContainerStyles on BoxDecoration {
  /// Gradient background decoration
  static BoxDecoration gradientBackground(ColorScheme colors) => BoxDecoration(
        borderRadius: K.borderRadius16,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colors.primaryContainer.withValues(alpha: K.opacity30),
            colors.secondaryContainer.withValues(alpha: K.opacity30),
          ],
        ),
      );
}
