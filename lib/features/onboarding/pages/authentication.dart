import 'package:devfest23/core/constants.dart';
import 'package:devfest23/core/enums/devfest_day.dart';
import 'package:devfest23/core/icons.dart';
import 'package:devfest23/core/themes/themes.dart';
import 'package:devfest23/core/widgets/buttons.dart';
import 'package:devfest23/features/onboarding/widgets/title_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../core/enums/tab_item.dart';
import '../../../core/router/routes.dart';
import '../widgets/go_back_button.dart';

enum AuthState { pending, success, failed }

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({super.key, this.authState});

  final AuthState? authState;

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
        child: switch (authState) {
          AuthState.pending => const _AuthenticationPending(),
          AuthState.success => const _AuthenticationSuccess(),
          AuthState.failed => const _AuthenticationFailure(),
          _ => const _AuthenticationHome(),
        },
      ),
    );
  }
}

class _AuthenticationHome extends StatelessWidget {
  const _AuthenticationHome();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleTile(
          emoji: '🛡️',
          title: 'Authentication',
          backgroundColor: const Color(0xfffde293).withOpacity(0.2),
        ),
        const SizedBox(height: Constants.largeVerticalGutter),
        Text(
          'We need your email to RSVP',
          style: DevFestTheme.of(context).textTheme?.headline02?.copyWith(
                color: DevFestTheme.of(context).onBackgroundColor,
                height: 1.2,
              ),
        ),
        const SizedBox(height: Constants.smallVerticalGutter),
        Padding(
          padding: const EdgeInsets.only(right: 50.0),
          child: Text(
            'To continue using the app to RSVP for your favourite talks we need to check if you are registered for the event.',
            style: DevFestTheme.of(context).textTheme?.body02?.copyWith(
                color:
                    MediaQuery.platformBrightnessOf(context) == Brightness.dark
                        ? DevfestColors.grey70
                        : DevfestColors.grey30),
          ),
        ),
        const SizedBox(height: Constants.largeVerticalGutter * 2),
        DevfestOutlinedButton(
          title: const Text('Continue with Gmail'),
          prefixIcon: SvgPicture.asset(
            AppIcons.googleLogo,
            height: 24,
            width: 24,
          ),
          onPressed: () {
            context.go(
              '${RoutePaths.onboarding}/${RoutePaths.auth}/?result=${AuthState.success.name}',
            );
          },
        ),
        const SizedBox(height: Constants.verticalGutter),
        DevfestOutlinedButton(
          title: const Text('Continue with Apple ID'),
          prefixIcon: const FaIcon(FontAwesomeIcons.apple),
          onPressed: () {},
        ),
      ],
    );
  }
}

class _AuthenticationSuccess extends StatelessWidget {
  const _AuthenticationSuccess();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleTile(
          emoji: '🥳',
          title: 'Authentication Successful!',
          backgroundColor: const Color(0xff81c995).withOpacity(0.2),
        ),
        const SizedBox(height: Constants.largeVerticalGutter),
        Text(
          'We have confirmed your email!',
          style: DevFestTheme.of(context).textTheme?.headline02?.copyWith(
                color: DevFestTheme.of(context).onBackgroundColor,
                height: 1.2,
              ),
        ),
        const SizedBox(height: Constants.smallVerticalGutter),
        Padding(
          padding: const EdgeInsets.only(right: 50.0),
          child: Text(
            'We are really glad to have you here with us at another DevFest! Make memories and have fun 🤩',
            style: DevFestTheme.of(context).textTheme?.body02?.copyWith(
                color:
                    MediaQuery.platformBrightnessOf(context) == Brightness.dark
                        ? DevfestColors.grey70
                        : DevfestColors.grey30),
          ),
        ),
        const SizedBox(height: Constants.largeVerticalGutter * 2),
        DevfestFilledButton(
          title: const Text('Continue to App'),
          onPressed: () {
            context.go(
              '${RoutePaths.onboarding}/${RoutePaths.auth}/?result=${AuthState.pending.name}',
            );
          },
        ),
      ],
    );
  }
}

class _AuthenticationPending extends StatelessWidget {
  const _AuthenticationPending();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleTile(
          emoji: '⌛',
          title: 'Authentication Pending',
          backgroundColor: const Color(0xfffde293).withOpacity(0.2),
        ),
        const SizedBox(height: Constants.largeVerticalGutter),
        Text(
          'It seems you have not registered',
          style: DevFestTheme.of(context).textTheme?.headline02?.copyWith(
                color: DevFestTheme.of(context).onBackgroundColor,
                height: 1.2,
              ),
        ),
        const SizedBox(height: Constants.smallVerticalGutter),
        Padding(
          padding: const EdgeInsets.only(right: 50.0),
          child: Text(
            'Your email is not in our data bse for now, but registration is still ongoing oh! Register now 😍',
            style: DevFestTheme.of(context).textTheme?.body02?.copyWith(
                color:
                    MediaQuery.platformBrightnessOf(context) == Brightness.dark
                        ? DevfestColors.grey70
                        : DevfestColors.grey30),
          ),
        ),
        const SizedBox(height: Constants.largeVerticalGutter * 2),
        DevfestFilledButton(
          title: const Text('Register Now'),
          onPressed: () {
            context.go(
              '${RoutePaths.onboarding}/${RoutePaths.auth}/?result=${AuthState.failed.name}',
            );
          },
        ),
        const SizedBox(height: Constants.verticalGutter),
        DevfestOutlinedButton(
          title: const Text('Maybe Later'),
          onPressed: () {},
        ),
      ],
    );
  }
}

class _AuthenticationFailure extends StatelessWidget {
  const _AuthenticationFailure();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleTile(
          emoji: '🥲',
          title: 'Email Not Found',
          backgroundColor: const Color(0xfff28b82).withOpacity(0.2),
        ),
        const SizedBox(height: Constants.largeVerticalGutter),
        Text(
          'It seems you did not register',
          style: DevFestTheme.of(context).textTheme?.headline02?.copyWith(
                color: DevFestTheme.of(context).onBackgroundColor,
                height: 1.2,
              ),
        ),
        const SizedBox(height: Constants.smallVerticalGutter),
        Padding(
          padding: const EdgeInsets.only(right: 50.0),
          child: Text(
            'Your email was not in our data base and sadly registration is closed. But, hey! Have an amazing DevFest 2023! 🥳',
            style: DevFestTheme.of(context).textTheme?.body02?.copyWith(
                color:
                    MediaQuery.platformBrightnessOf(context) == Brightness.dark
                        ? DevfestColors.grey70
                        : DevfestColors.grey30),
          ),
        ),
        const SizedBox(height: Constants.largeVerticalGutter * 2),
        DevfestOutlinedButton(
          title: const Text('Proceed to App'),
          onPressed: () {
            context.go('/app/${TabItem.home.name}/${DevfestDay.day2.name}');
          },
        ),
      ],
    );
  }
}