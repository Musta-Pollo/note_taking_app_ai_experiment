import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  /// Light theme configuration
  static ThemeData get lightTheme {
    return FlexThemeData.light(
      scheme: FlexScheme.blue,
      surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
      blendLevel: 7,
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 10,
        blendOnColors: false,
        useMaterial3Typography: true,
        useM2StyleDividerInM3: true,
        alignedDropdown: true,
        useInputDecoratorThemeInDialogs: true,
      ),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      swapLegacyOnMaterial3: true,
      fontFamily: GoogleFonts.nunito().fontFamily,
    ).copyWith(
      // Custom theme extensions
      extensions: <ThemeExtension<dynamic>>[
        NotesThemeData.light(),
      ],
    );
  }

  /// Dark theme configuration
  static ThemeData get darkTheme {
    return FlexThemeData.dark(
      scheme: FlexScheme.blue,
      surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
      blendLevel: 13,
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 20,
        useMaterial3Typography: true,
        useM2StyleDividerInM3: true,
        alignedDropdown: true,
        useInputDecoratorThemeInDialogs: true,
      ),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      swapLegacyOnMaterial3: true,
      fontFamily: GoogleFonts.nunito().fontFamily,
    ).copyWith(
      // Custom theme extensions
      extensions: <ThemeExtension<dynamic>>[
        NotesThemeData.dark(),
      ],
    );
  }

  /// High contrast light theme
  static ThemeData get lightHighContrastTheme {
    return FlexThemeData.light(
      scheme: FlexScheme.blue,
      surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
      blendLevel: 0,
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 0,
        useMaterial3Typography: true,
        useM2StyleDividerInM3: true,
        alignedDropdown: true,
        useInputDecoratorThemeInDialogs: true,
      ),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      swapLegacyOnMaterial3: true,
      fontFamily: GoogleFonts.nunito().fontFamily,
    );
  }

  /// High contrast dark theme
  static ThemeData get darkHighContrastTheme {
    return FlexThemeData.dark(
      scheme: FlexScheme.blue,
      surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
      blendLevel: 0,
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 0,
        useMaterial3Typography: true,
        useM2StyleDividerInM3: true,
        alignedDropdown: true,
        useInputDecoratorThemeInDialogs: true,
      ),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      swapLegacyOnMaterial3: true,
      fontFamily: GoogleFonts.nunito().fontFamily,
    );
  }
}

/// Custom theme extension for notes-specific styling
class NotesThemeData extends ThemeExtension<NotesThemeData> {
  const NotesThemeData({
    required this.noteCardColor,
    required this.noteCardShadowColor,
    required this.categorySidebarColor,
    required this.searchBarColor,
    required this.syncIndicatorColor,
  });

  final Color noteCardColor;
  final Color noteCardShadowColor;
  final Color categorySidebarColor;
  final Color searchBarColor;
  final Color syncIndicatorColor;

  factory NotesThemeData.light() {
    return const NotesThemeData(
      noteCardColor: Color(0xFFFAFAFA),
      noteCardShadowColor: Color(0x1A000000),
      categorySidebarColor: Color(0xFFF5F5F5),
      searchBarColor: Color(0xFFFFFFFF),
      syncIndicatorColor: Color(0xFF4CAF50),
    );
  }

  factory NotesThemeData.dark() {
    return const NotesThemeData(
      noteCardColor: Color(0xFF2D2D2D),
      noteCardShadowColor: Color(0x33000000),
      categorySidebarColor: Color(0xFF1E1E1E),
      searchBarColor: Color(0xFF3A3A3A),
      syncIndicatorColor: Color(0xFF66BB6A),
    );
  }

  @override
  ThemeExtension<NotesThemeData> copyWith({
    Color? noteCardColor,
    Color? noteCardShadowColor,
    Color? categorySidebarColor,
    Color? searchBarColor,
    Color? syncIndicatorColor,
  }) {
    return NotesThemeData(
      noteCardColor: noteCardColor ?? this.noteCardColor,
      noteCardShadowColor: noteCardShadowColor ?? this.noteCardShadowColor,
      categorySidebarColor: categorySidebarColor ?? this.categorySidebarColor,
      searchBarColor: searchBarColor ?? this.searchBarColor,
      syncIndicatorColor: syncIndicatorColor ?? this.syncIndicatorColor,
    );
  }

  @override
  ThemeExtension<NotesThemeData> lerp(
    ThemeExtension<NotesThemeData>? other,
    double t,
  ) {
    if (other is! NotesThemeData) {
      return this;
    }

    return NotesThemeData(
      noteCardColor: Color.lerp(noteCardColor, other.noteCardColor, t)!,
      noteCardShadowColor: Color.lerp(noteCardShadowColor, other.noteCardShadowColor, t)!,
      categorySidebarColor: Color.lerp(categorySidebarColor, other.categorySidebarColor, t)!,
      searchBarColor: Color.lerp(searchBarColor, other.searchBarColor, t)!,
      syncIndicatorColor: Color.lerp(syncIndicatorColor, other.syncIndicatorColor, t)!,
    );
  }
}

/// Extension to easily access custom theme colors
extension NotesThemeAccess on BuildContext {
  NotesThemeData get notesTheme {
    return Theme.of(this).extension<NotesThemeData>()!;
  }
}