import 'package:waifu_swiper/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ListTile with theme switch
class ThemeSwitchTile extends StatelessWidget {
  const ThemeSwitchTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.dark_mode),
      title: const Text("Dark theme"),
      trailing: Consumer<ThemeProvider>(
        builder: (context, notifier, child) {
          return Switch(
            value: notifier.isDark,
            onChanged: (value) => notifier.toggleTheme(),
          );
        },
      ),
    );
  }
}