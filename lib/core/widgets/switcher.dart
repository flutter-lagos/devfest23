import 'package:devfest23/core/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../themes/themes.dart';

class DevfestSwitcher extends ConsumerWidget {
  const DevfestSwitcher({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context, ref) {
    return SizedBox(
      height: 24,
      child: Switch.adaptive(
        value: value,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        thumbColor: MaterialStateProperty.resolveWith(
          (states) {
            if (states.contains(MaterialState.selected)) {
              return DevFestTheme.of(context).onBackgroundColor;
            }

            return ref.watch(isDarkProvider)
                ? DevfestColors.grey80
                : DevfestColors.grey20;
          },
        ),
        trackColor: MaterialStateProperty.resolveWith((states) {
          return ref.watch(isDarkProvider)
              ? DevfestColors.grey10
              : DevfestColors.grey90;
        }),
        activeColor: DevFestTheme.of(context).onBackgroundColor,
        onChanged: onChanged,
      ),
    );
  }
}
