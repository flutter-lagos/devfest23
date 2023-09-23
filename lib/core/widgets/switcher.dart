import '../providers/providers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      height: 24.h,
      child: CupertinoTheme(
        data: CupertinoThemeData(
          primaryColor: ref.watch(isDarkProvider)
              ? DevfestColors.grey10
              : DevfestColors.grey90,
        ),
        child: CupertinoSwitch(
          value: value,
          applyTheme: true,
          thumbColor: DevfestColors.grey10,
          // trackColor: ref.watch(isDarkProvider)
          //     ? DevfestColors.grey10
          //     : DevfestColors.grey90,
          activeColor: DevFestTheme.of(context).onBackgroundColor,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
