import 'theme_data.dart';
import 'package:flutter/material.dart';

class DevfestTheme extends StatelessWidget {
  final DevFestTheme data;
  final Widget child;

  const DevfestTheme({
    super.key,
    required this.data,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeExtensions = Map<Object, ThemeExtension>.from(theme.extensions);

    themeExtensions[DevFestTheme] = data;
    return Theme(
      data: theme.copyWith(extensions: themeExtensions.values),
      child: child,
    );
  }
}
