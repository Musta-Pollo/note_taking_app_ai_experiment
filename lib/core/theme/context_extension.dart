// Context Extension
import 'package:flutter/material.dart';

extension ThemeContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  ColorScheme get colorScheme => theme.colorScheme;

  TextTheme get textTheme => theme.textTheme;
}

/// Extension on BuildContext for showing various types of messages using SnackBar
extension MessageExtension on BuildContext {}
