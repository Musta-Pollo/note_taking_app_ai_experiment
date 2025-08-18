import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import 'package:note_taking_app/shared/components/section_card.dart';
import 'components/app_info_section.dart';
import 'components/theme_settings_section.dart';

@RoutePage()
class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SectionCard(
            title: 'Appearance',
            icon: Icons.palette,
            children: const [
              ThemeSettingsSection(),
            ],
          ),
          Gap(16),
          const AppInfoSection(),
        ],
      ),
    );
  }
}
