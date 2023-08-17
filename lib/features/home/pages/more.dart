import 'package:devfest23/core/widgets/switcher.dart';
import 'package:devfest23/features/home/widgets/more_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    return Scaffold(
      backgroundColor: DevFestTheme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: DevFestTheme.of(context).backgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        leadingWidth: 100,
        leading: Row(
          children: [
            const SizedBox(width: Constants.horizontalMargin),
            SvgPicture.asset(
              AppIcons.devfestLogo,
              height: 16,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: Constants.horizontalMargin),
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
            const SizedBox(height: Constants.verticalGutter),
            MoreTile(
              leading: const Icon(Symbols.account_circle),
              title: const Text('Profile'),
              trailing: const Icon(Icons.chevron_right_rounded),
              onPressed: () {},
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
              onPressed: () {},
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
      height: 2,
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(32)),
        color: DevfestColors.grey90,
      ),
    );
  }
}
