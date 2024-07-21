import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:waifu_swiper/components/theme_switch_tile.dart';
import 'package:waifu_swiper/pages/settings_page.dart';
import 'package:waifu_swiper/theme/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('SettingsPage displays the theme switch tile', (WidgetTester tester) async {
    // Initialize the ThemeProvider with default values
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => ThemeProvider(),
        child: const MaterialApp(
          home: SettingsPage(),
        ),
      ),
    );

    // Check if the ThemeSwitchTile is present
    expect(find.byType(ThemeSwitchTile), findsOneWidget);
    expect(find.text('Dark theme'), findsOneWidget);
    expect(find.byIcon(Icons.dark_mode), findsOneWidget);
  });

  testWidgets('ThemeSwitchTile toggles the theme', (WidgetTester tester) async {
    // Initialize the ThemeProvider with default values
    final themeProvider = ThemeProvider();
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => themeProvider,
        child: const MaterialApp(
          home: SettingsPage(),
        ),
      ),
    );

    // Initially, the switch should reflect the light theme
    expect(themeProvider.isDark, isFalse);
    expect(find.byWidgetPredicate(
      (widget) => widget is Switch && widget.value == false
    ), findsOneWidget);

    // Toggle the switch
    await tester.tap(find.byType(Switch));
    await tester.pump();

    // After toggling, the switch should reflect the dark theme
    expect(themeProvider.isDark, isTrue);
    expect(find.byWidgetPredicate(
      (widget) => widget is Switch && widget.value == true
    ), findsOneWidget);
  });

  testWidgets('Switch toggles theme correctly in SettingsPage', (WidgetTester tester) async {
    final themeProvider = ThemeProvider();
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => themeProvider,
        child: const MaterialApp(
          home: SettingsPage(),
        ),
      ),
    );

    // Verify initial switch state
    expect(themeProvider.isDark, isFalse);
    expect(find.byType(Switch), findsOneWidget);

    // Tap the switch to toggle the theme
    await tester.tap(find.byType(Switch));
    await tester.pump();

    // Verify that the theme has been toggled to dark
    expect(themeProvider.isDark, isTrue);
    expect(find.byWidgetPredicate(
      (widget) => widget is Switch && widget.value == true
    ), findsOneWidget);

    // Tap the switch again to toggle the theme back to light
    await tester.tap(find.byType(Switch));
    await tester.pump();

    // Verify that the theme has been toggled back to light
    expect(themeProvider.isDark, isFalse);
    expect(find.byWidgetPredicate(
      (widget) => widget is Switch && widget.value == false
    ), findsOneWidget);
  });
}
