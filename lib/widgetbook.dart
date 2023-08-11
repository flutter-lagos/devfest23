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
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
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
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
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
