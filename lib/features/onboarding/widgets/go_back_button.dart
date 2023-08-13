import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/themes/themes.dart';
import '../../../core/widgets/widgets.dart';

class GoBackButton extends StatelessWidget {
  const GoBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    final buttonTheme = DevFestTheme.of(context).buttonTheme;
    final theme = DevFestTheme.of(context);
    return DevfestTheme(
      data: theme.copyWith(
        buttonTheme: buttonTheme?.copyWith(
          backgroundColor: theme.backgroundColor,
          textStyle: buttonTheme.textStyle.copyWith(
            color: theme.onBackgroundColor,
          ),
          iconColor: theme.onBackgroundColor,
        ),
      ),
      child: DevfestFilledButton(
        onPressed: context.pop,
        prefixIcon: const Icon(Icons.arrow_back),
        title: const Text('Go Back'),
      ),
    );
  }
}
