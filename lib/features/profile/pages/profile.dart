import 'package:devfest23/core/constants.dart';
import 'package:devfest23/core/images.dart';
import 'package:devfest23/core/router/navigator.dart';
import 'package:devfest23/core/router/routes.dart';
import 'package:flutter/material.dart';

import '../../../core/themes/themes.dart';
import '../../../core/widgets/widgets.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DevFestTheme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: DevFestTheme.of(context).backgroundColor,
        elevation: 0,
        leadingWidth: 120,
        leading: const GoBackButton(),
      ),
      body: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: Constants.horizontalMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text.rich(
              TextSpan(
                text: '🙂',
                style: DevFestTheme.of(context).textTheme?.title01,
                children: const [
                  WidgetSpan(child: SizedBox(width: 4)),
                  TextSpan(text: 'Profile')
                ],
              ),
            ),
            const SizedBox(height: Constants.verticalGutter),
            const ProfileAvatar(),
            const Padding(
              padding: EdgeInsets.symmetric(
                  vertical: Constants.largeVerticalGutter, horizontal: 40),
              child: UserInfo(),
            ),
            const Spacer(),
            DevfestOutlinedButton(
              title: const Text('Logout'),
              onPressed: () {
                context.go(RoutePaths.onboarding);
              },
            ),
            const SizedBox(height: Constants.smallVerticalGutter),
          ],
        ),
      ),
    );
  }
}

class UserInfo extends StatelessWidget {
  const UserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const _AttendanceChip(),
        const SizedBox(height: Constants.largeVerticalGutter),
        Text(
          'Osamudiame Aghahowa',
          style: DevFestTheme.of(context)
              .textTheme
              ?.title02
              ?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 7),
        Text(
          'osamudiame360@gmail.com',
          style: DevFestTheme.of(context).textTheme?.body03?.copyWith(
                color: DevFestTheme.of(context).inverseBackgroundColor,
                fontWeight: FontWeight.w500,
              ),
        )
      ],
    );
  }
}

class _AttendanceChip extends StatelessWidget {
  const _AttendanceChip();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Constants.horizontalGutter * 2,
        vertical: 6,
      ),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(24)),
        color: DevfestColors.yellowSecondary,
      ),
      child: Text(
        'Attendee',
        style: DevFestTheme.of(context).textTheme?.body04?.copyWith(
            color: DevfestColors.grey10, fontWeight: FontWeight.w500),
      ),
    );
  }
}

class ProfileAvatar extends StatefulWidget {
  const ProfileAvatar({super.key});

  @override
  State<ProfileAvatar> createState() => _ProfileAvatarState();
}

class _ProfileAvatarState extends State<ProfileAvatar> {
  late final AssetImage image;

  @override
  void initState() {
    super.initState();

    image = const AssetImage(AppImages.devfestBanner);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(image, context);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 232,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned.fill(
            top: 0,
            left: 0,
            right: 0,
            bottom: 40,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(24)),
                image: DecorationImage(image: image, fit: BoxFit.fill),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: DevfestColors.blue,
                border:
                    Border.all(color: DevfestColors.yellowSecondary, width: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
