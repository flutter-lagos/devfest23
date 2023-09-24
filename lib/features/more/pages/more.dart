import '../../../core/router/navigator.dart';
import '../../../core/router/routes.dart';
import '../../../core/widgets/switcher.dart';
import '../../home/widgets/more_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:material_symbols_icons/symbols.dart';

import '../../../core/constants.dart';
import '../../../core/icons.dart';
import '../../../core/providers/providers.dart';
import '../../../core/themes/themes.dart';

class MorePage extends ConsumerStatefulWidget {
  const MorePage({super.key});

  @override
  ConsumerState<MorePage> createState() => _MorePageState();
}

class _MorePageState extends ConsumerState<MorePage> {
  @override
  Widget build(BuildContext context) {
    var theme = DevFestTheme.of(context);
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        backgroundColor: theme.backgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        leadingWidth: 100,
        leading: Row(
          children: [
            Constants.horizontalMargin.horizontalSpace,
            SvgPicture.asset(
              AppIcons.devfestLogo,
              height: 16.h,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: Constants.horizontalMargin)
                .w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text.rich(
              TextSpan(
                text: '🥳',
                style: DevFestTheme.of(context).textTheme?.title01,
                children: const [
                  WidgetSpan(child: SizedBox(width: 4)),
                  TextSpan(text: 'More')
                ],
              ),
            ),
            Constants.verticalGutter.verticalSpace,
            MoreTile(
              leading: const Icon(Symbols.account_circle),
              title: const Text('Profile'),
              trailing: const Icon(Icons.chevron_right_rounded),
              onPressed: () {
                context.go(RoutePaths.profile);
              },
            ),
            const _MoreDivider(),
            MoreTile(
              leading: const Icon(Symbols.partly_cloudy_night),
              title: const Text('Dark Mode'),
              trailing: DevfestSwitcher(
                value: ref.watch(isDarkProvider),
                onChanged: (enabled) {
                  ref.read(themeManagerProvider.notifier).updateThemeMode(
                      enabled ? ThemeMode.dark : ThemeMode.light);
                },
              ),
            ),
            const _MoreDivider(),
            MoreTile(
              leading: const Icon(Symbols.headset_mic),
              title: const Text('Contact Us'),
              trailing: const Icon(Icons.chevron_right_rounded),
              onPressed: () {},
            ),
            const _MoreDivider(),
            MoreTile(
              leading: Align(
                child: SvgPicture.asset(
                  AppIcons.devfestLogo,
                  height: 10,
                  width: 24,
                  fit: BoxFit.contain,
                ),
              ),
              title: const Text('Join The Community'),
              trailing: const Icon(Icons.chevron_right_rounded),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class _MoreDivider extends StatelessWidget {
  const _MoreDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 2.h,
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(32)),
        color: DevfestColors.grey90,
      ),
    );
  }
}
