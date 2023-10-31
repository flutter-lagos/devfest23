import 'package:devfest23/core/exceptions/exceptions.dart';
import 'package:devfest23/core/ui_state_model/ui_state_model.dart';
import 'package:devfest23/core/widgets/widgets.dart';
import 'package:devfest23/features/onboarding/application/application.dart';

import '../../../core/constants.dart';
import '../../../core/router/navigator.dart';
import '../../../core/themes/themes.dart';
import '../widgets/title_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/enums/tab_item.dart';
import '../../../core/providers/providers.dart';
import '../../../core/router/routes.dart';

enum AuthState { pending, success, failed }

final authSubtitleTextColorProvider = Provider.autoDispose<Color>((ref) {
  return ref.watch(isDarkProvider)
      ? DevfestColors.grey70
      : DevfestColors.grey30;
});

class AuthenticationPage extends ConsumerStatefulWidget {
  const AuthenticationPage({super.key, this.authState});

  final AuthState? authState;

  @override
  ConsumerState<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends ConsumerState<AuthenticationPage> {
  @override
  void initState() {
    super.initState();

    ref.listenManual(authViewModelProvider, (previous, next) {
      switch ((next.viewState, next.exception)) {
        case (ViewState.success, _):
          context.go(
            '${RoutePaths.onboarding}/${RoutePaths.auth}?result=${AuthState.success.name}',
          );
        case (ViewState.error, final exception):
          if (exception is UserNotRegisteredException) {
            context.go(
              '${RoutePaths.onboarding}/${RoutePaths.auth}?result=${AuthState.failed.name}',
            );
          }

          if (exception is InvalidTicketIdException) {
            context.go(
              '${RoutePaths.onboarding}/${RoutePaths.auth}?result=${AuthState.pending.name}',
            );
          }
        case _:
          break;
      }
      if (next.viewState == ViewState.error) {}

      if (next.viewState == ViewState.success) {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return OnScreenLoader(
      isLoading: ref.watch(authIsLoadingProvider),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: DevFestTheme.of(context).backgroundColor,
          appBar: AppBar(
            backgroundColor: DevFestTheme.of(context).backgroundColor,
            elevation: 0,
            surfaceTintColor: Colors.transparent,
            leadingWidth: 120,
            leading: const GoBackButton(),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Constants.horizontalMargin),
            child: switch (widget.authState) {
              AuthState.pending => const _AuthenticationPending(),
              AuthState.success => const _AuthenticationSuccess(),
              AuthState.failed => const _AuthenticationFailure(),
              _ => const _AuthenticationHome(),
            },
          ),
        ),
      ),
    );
  }
}

class _AuthenticationHome extends ConsumerWidget {
  const _AuthenticationHome();

  @override
  Widget build(BuildContext context, ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleTile(
          emoji: '🛡️',
          title: 'Authentication',
          backgroundColor: Color(0xfffde293),
        ),
        Constants.largeVerticalGutter.verticalSpace,
        Expanded(
          child: SingleChildScrollView(
            child: Form(
              autovalidateMode: ref.watch(showFormErrorsProvider)
                  ? AutovalidateMode.always
                  : AutovalidateMode.disabled,
              child: FocusTraversalGroup(
                child: Column(
                  children: [
                    Text(
                      'We need your ticket number to RSVP',
                      style: DevFestTheme.of(context)
                          .textTheme
                          ?.headline02
                          ?.copyWith(
                            color: DevFestTheme.of(context).onBackgroundColor,
                            height: 1.2,
                          ),
                    ),
                    Constants.smallVerticalGutter.verticalSpace,
                    Padding(
                      padding: const EdgeInsets.only(right: 50.0),
                      child: Text(
                        'To continue using the app to RSVP for your favourite talks we need to check if you are registered for the event.',
                        style: DevFestTheme.of(context)
                            .textTheme
                            ?.body02
                            ?.copyWith(
                                color:
                                    ref.watch(authSubtitleTextColorProvider)),
                      ),
                    ),
                    Constants.verticalGutter.verticalSpace,
                    DevfestTextFormField(
                      title: 'Email Address',
                      info: 'Use the email you used to register',
                      hint: 'Enter your email address',
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      onChanged: ref
                          .read(authViewModelProvider.notifier)
                          .emailAddressOnChanged,
                      validator: (_) => ref
                          .read(authViewModelProvider)
                          .form
                          .emailAddress
                          .validationError,
                    ),
                    Constants.smallVerticalGutter.verticalSpace,
                    DevfestTextFormField(
                      title: 'Ticket Number',
                      info: 'Ticket number came with the email we sent',
                      hint: 'Enter your ticket number',
                      textInputAction: TextInputAction.done,
                      onChanged: ref
                          .read(authViewModelProvider.notifier)
                          .passwordOnChanged,
                      validator: (_) => ref
                          .read(authViewModelProvider)
                          .form
                          .password
                          .validationError,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        DevfestFilledButton(
          title: const Text('Login'),
          onPressed: () {
            FocusScope.of(context).unfocus();
            ref //
                .read(authViewModelProvider.notifier) //
                .loginOnTap();
          },
        ),
        (MediaQuery.viewPaddingOf(context).bottom + 10).verticalSpace,
      ],
    );
  }
}

class _AuthenticationSuccess extends ConsumerWidget {
  const _AuthenticationSuccess();

  @override
  Widget build(BuildContext context, ref) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TitleTile(
            emoji: '🥳',
            title: 'Authentication Successful!',
            backgroundColor: Color(0xff81c995),
          ),
          Constants.largeVerticalGutter.verticalSpace,
          Text(
            'We have confirmed your email!',
            style: DevFestTheme.of(context).textTheme?.headline02?.copyWith(
                  color: DevFestTheme.of(context).onBackgroundColor,
                  height: 1.2,
                ),
          ),
          Constants.smallVerticalGutter.verticalSpace,
          Padding(
            padding: const EdgeInsets.only(right: 50.0),
            child: Text(
              'We are really glad to have you here with us at another DevFest! Make memories and have fun 🤩',
              style: DevFestTheme.of(context)
                  .textTheme
                  ?.body02
                  ?.copyWith(color: ref.watch(authSubtitleTextColorProvider)),
            ),
          ),
          const Spacer(),
          DevfestFilledButton(
            title: const Text('Continue to App'),
            onPressed: () {
              context.pushNamedAndClear('/app/${TabItem.home.name}');
            },
          ),
        ],
      ),
    );
  }
}

class _AuthenticationPending extends ConsumerWidget {
  const _AuthenticationPending();

  @override
  Widget build(BuildContext context, ref) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TitleTile(
            emoji: '⌛',
            title: 'Authentication Pending',
            backgroundColor: Color(0xfffde293),
          ),
          Constants.largeVerticalGutter.verticalSpace,
          Text(
            'It seems you have not registered',
            style: DevFestTheme.of(context).textTheme?.headline02?.copyWith(
                  color: DevFestTheme.of(context).onBackgroundColor,
                  height: 1.2,
                ),
          ),
          Constants.smallVerticalGutter.verticalSpace,
          Padding(
            padding: const EdgeInsets.only(right: 50.0),
            child: Text(
              'Your email is not in our database for now, but registration is still ongoing oh! Register now 😍',
              style: DevFestTheme.of(context)
                  .textTheme
                  ?.body02
                  ?.copyWith(color: ref.watch(authSubtitleTextColorProvider)),
            ),
          ),
          const Spacer(),
          DevfestFilledButton(
            title: const Text('Register Now'),
            onPressed: () {
              // TODO: register now
            },
          ),
          Constants.verticalGutter.verticalSpace,
          DevfestOutlinedButton(
            title: const Text('Maybe Later'),
            onPressed: () {
              context.pushNamedAndClear('/app/${TabItem.home.name}');
            },
          ),
        ],
      ),
    );
  }
}

class _AuthenticationFailure extends ConsumerWidget {
  const _AuthenticationFailure();

  @override
  Widget build(BuildContext context, ref) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TitleTile(
            emoji: '🥲',
            title: 'Email Not Found',
            backgroundColor: Color(0xfff28b82),
          ),
          Constants.largeVerticalGutter.verticalSpace,
          Text(
            'It seems you did not register',
            style: DevFestTheme.of(context).textTheme?.headline02?.copyWith(
                  color: DevFestTheme.of(context).onBackgroundColor,
                  height: 1.2,
                ),
          ),
          Constants.smallVerticalGutter.verticalSpace,
          Padding(
            padding: const EdgeInsets.only(right: 50.0),
            child: Text(
              'Your email was not in our data base and sadly registration is closed. But, hey! Have an amazing DevFest 2023! 🥳',
              style: DevFestTheme.of(context)
                  .textTheme
                  ?.body02
                  ?.copyWith(color: ref.watch(authSubtitleTextColorProvider)),
            ),
          ),
          const Spacer(),
          DevfestFilledButton(
            title: const Text('Proceed to App'),
            onPressed: () {
              context.pushNamedAndClear('/app/${TabItem.home.name}');
            },
          ),
        ],
      ),
    );
  }
}
