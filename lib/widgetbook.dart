import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'core/themes/themes.dart';
import 'widgetbook.directories.g.dart';

void main() {
  runApp(const WidgetbookApp());
}

@widgetbook.App()
class WidgetbookApp extends StatelessWidget {
  const WidgetbookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      directories: directories,
      addons: [
        ThemeAddon(
          themes: [
            WidgetbookTheme(
              name: 'Light',
              data: ThemeData(
                brightness: Brightness.light,
                colorScheme: ColorScheme.fromSeed(
                  seedColor: Colors.deepPurple,
                  brightness: Brightness.light,
                ),
                useMaterial3: true,
                textTheme: const TextTheme(
                    bodyMedium: TextStyle(color: DevfestColors.grey0)),
                extensions: const <ThemeExtension<dynamic>>[
                  /// Use the below format for raw theme data
                  /// DevFestTheme(textTheme: DevfestTextTheme()),
                  DevFestTheme.light(),
                ],
              ),
            ),
            WidgetbookTheme(
              name: 'Dark',
              data: ThemeData(
                brightness: Brightness.dark,
                colorScheme: ColorScheme.fromSeed(
                  seedColor: Colors.deepPurple,
                  brightness: Brightness.dark,
                ),
                useMaterial3: true,
                textTheme: const TextTheme(
                    bodyMedium: TextStyle(color: DevfestColors.background)),
                extensions: const <ThemeExtension<dynamic>>[
                  /// Use the below format for raw theme data
                  /// DevFestTheme(textTheme: DevfestTextTheme()),
                  DevFestTheme.dark(),
                ],
              ),
            ),
          ],
          themeBuilder: (context, theme, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: theme,
              home: Material(child: child),
            );
          },
        )
      ],
    );
  }
}
