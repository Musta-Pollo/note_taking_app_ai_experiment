import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

class ThemeSettingsSection extends StatelessWidget {
  const ThemeSettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AdaptiveThemeMode>(
      valueListenable: AdaptiveTheme.of(context).modeChangeNotifier,
      builder: (_, mode, child) {
        return Column(
          children: [
            SwitchListTile(
              secondary: Icon(
                mode == AdaptiveThemeMode.dark 
                  ? Icons.dark_mode 
                  : Icons.light_mode
              ),
              title: Text(
                mode == AdaptiveThemeMode.dark 
                  ? 'Dark Mode' 
                  : 'Light Mode'
              ),
              subtitle: Text(_getThemeModeDescription(mode)),
              value: mode == AdaptiveThemeMode.dark,
              onChanged: (value) {
                if (value) {
                  AdaptiveTheme.of(context).setDark();
                } else {
                  AdaptiveTheme.of(context).setLight();
                }
              },
            ),
            const Divider(height: 1),
            ListTile(
              leading: const Icon(Icons.brightness_auto),
              title: const Text('System Theme'),
              subtitle: const Text('Follow system setting'),
              trailing: mode == AdaptiveThemeMode.system
                  ? const Icon(Icons.check, color: Colors.green)
                  : null,
              onTap: () {
                AdaptiveTheme.of(context).setSystem();
              },
            ),
          ],
        );
      },
    );
  }

  String _getThemeModeDescription(AdaptiveThemeMode mode) {
    return switch (mode) {
      AdaptiveThemeMode.light => 'Always use light theme',
      AdaptiveThemeMode.dark => 'Always use dark theme',
      AdaptiveThemeMode.system => 'Follow system setting',
    };
  }
}