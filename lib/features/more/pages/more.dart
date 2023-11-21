import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

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
              subtitle: const Text('See your email address and logout options'),
              trailing: const Icon(Icons.chevron_right_rounded),
              onPressed: () {
                context.go(RoutePaths.profile);
              },
            ),
            MoreTile(
              leading: const Icon(Symbols.partly_cloudy_night),
              title: const Text('Dark Mode'),
              subtitle: const Text('Toggle between light and dark mode'),
              trailing: DevfestSwitcher(
                value: ref.watch(isDarkProvider),
                onChanged: (enabled) {
                  ref.read(themeManagerProvider.notifier).updateThemeMode(
                      enabled ? ThemeMode.dark : ThemeMode.light);
                },
              ),
            ),
            MoreTile(
              leading: const Icon(Symbols.headset_mic),
              title: const Text('Contact Us'),
              subtitle: const Text('Ask questions and make enquiries'),
              trailing: const Icon(Icons.chevron_right_rounded),
              onPressed: () {
                _launchUrl('mailto:Team@gdglagos.com');
              },
            ),
            MoreTile(
              leading: const Icon(Symbols.location_pin),
              title: const Text('DevFest Venue Map'),
              subtitle: const Text('Find your way around Landmark Center'),
              trailing: const Icon(Icons.arrow_outward),
              onPressed: () {
                _launchUrl('https://devfestlagos.com/map');
              },
            ),
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
              subtitle: const Text('Make magic with us by joining a GDG'),
              trailing: const Icon(Icons.chevron_right_rounded),
              onPressed: () {
                _launchUrl('https://gdg.community.dev/gdg-lagos/');
              },
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal:
                    Constants.horizontalMargin + Constants.verticalGutter,
              ).w,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Made with love, vibes and GeekTutor\'s soul obliterating deadlines🥰',
                    textAlign: TextAlign.center,
                    style: DevFestTheme.of(context)
                        .textTheme
                        ?.body03
                        ?.copyWith(color: DevfestColors.grey40),
                  ),
                  const AppVersionPill(),
                ],
              ),
            ),
            Constants.largeVerticalGutter.verticalSpace,
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {}
  }
}

class AppVersionPill extends StatelessWidget {
  const AppVersionPill({super.key});

  static final _appVersionFuture = PackageInfo.fromPlatform();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _appVersionFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final versionInfo = snapshot.requireData;

          return Container(
            margin: const EdgeInsets.only(top: Constants.verticalGutter).w,
            padding: const EdgeInsets.symmetric(
              horizontal: Constants.smallVerticalGutter,
              vertical: Constants.smallVerticalGutter / 2,
            ).w,
            decoration: const BoxDecoration(
              borderRadius:
                  BorderRadius.all(Radius.circular(Constants.verticalGutter)),
              color: Color(0xffd8f3df),
            ),
            child: Text(
              'Version ${versionInfo.version}',
              style: DevFestTheme.of(context).textTheme?.body05?.copyWith(
                    color: DevfestColors.grey0,
                  ),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
