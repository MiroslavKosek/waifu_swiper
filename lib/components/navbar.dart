import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class Navbar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;

  const Navbar({
    required this.selectedIndex,
    required this.onTabSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GNav(
      backgroundColor: Theme.of(context).colorScheme.surface,
      color: Theme.of(context).colorScheme.onSurface,
      haptic: true,
      gap: 8,
      activeColor: Theme.of(context).colorScheme.surface,
      tabBackgroundColor: Theme.of(context).colorScheme.primary,
      padding: const EdgeInsets.all(16),
      selectedIndex: selectedIndex,
      onTabChange: onTabSelected,
      tabs: const [
        GButton(
          icon: Icons.check,
          text: 'SFW',
        ),
        GButton(
          icon: Icons.clear,
          text: 'NSFW',
        ),
        GButton(
          icon: Icons.settings,
          text: 'Settings',
        ),
      ],
    );
  }
}