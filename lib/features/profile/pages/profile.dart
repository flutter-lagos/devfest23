import 'package:cached_network_image/cached_network_image.dart';
import 'package:devfest23/core/ui_state_model/ui_state_model.dart';
import 'package:devfest23/features/profile/application/view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants.dart';
import '../../../core/images.dart';
import '../../../core/router/navigator.dart';
import '../../../core/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/themes/themes.dart';
import '../../../core/widgets/widgets.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return OnScreenLoader(
      isLoading: ref.watch(
              profileViewModelProvider.select((value) => value.viewState)) ==
          ViewState.loading,
      child: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        initialData: null,
        builder: (context, snapshot) {
          return Scaffold(
            backgroundColor: DevFestTheme.of(context).backgroundColor,
            appBar: AppBar(
              backgroundColor: DevFestTheme.of(context).backgroundColor,
              elevation: 0,
              leadingWidth: 120,
              leading: const GoBackButton(),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(
                      horizontal: Constants.horizontalMargin)
                  .w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text.rich(
                    TextSpan(
                      text: '🙂',
                      style: DevFestTheme.of(context).textTheme?.title01,
                      children: [
                        WidgetSpan(child: 4.horizontalSpace),
                        const TextSpan(text: 'Profile')
                      ],
                    ),
                  ),
                  Constants.verticalGutter.verticalSpace,
                  ProfileAvatar(user: snapshot.data),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: Constants.largeVerticalGutter,
                      horizontal: 40,
                    ).w,
                    child: UserInfo(user: snapshot.data),
                  ),
                  const Spacer(),
                  _ProfileActionButton(user: snapshot.data),
                  Constants.smallVerticalGutter.verticalSpace,
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class UserInfo extends StatelessWidget {
  const UserInfo({super.key, required this.user});

  final User? user;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        user == null ? const _GuestChip() : const _AttendanceChip(),
        const SizedBox(height: Constants.largeVerticalGutter),
        Text(
          user == null ? 'You\'re not logged in' : user!.displayName ?? '',
          style: DevFestTheme.of(context)
              .textTheme
              ?.title02
              ?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 7),
        Text(
          user == null ? 'Login to view your profile' : user!.email ?? '',
          style: DevFestTheme.of(context).textTheme?.body03?.copyWith(
                color: DevFestTheme.of(context).inverseBackgroundColor,
                fontWeight: FontWeight.w500,
              ),
        )
      ],
    );
  }
}

class _ProfileActionButton extends ConsumerWidget {
  const _ProfileActionButton({required this.user});

  final User? user;

  @override
  Widget build(BuildContext context, ref) {
    if (user != null) {
      return DevfestOutlinedButton(
        title: const Text('Logout'),
        onPressed: ref.read(profileViewModelProvider.notifier).logout,
      );
    }

    return DevfestFilledButton(
      title: const Text('Login'),
      onPressed: () {
        AppNavigator.pushNamedAndClear(RoutePaths.onboarding);
      },
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

class _GuestChip extends StatelessWidget {
  const _GuestChip();

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
        'Guest',
        style: DevFestTheme.of(context).textTheme?.body04?.copyWith(
            color: DevfestColors.grey10, fontWeight: FontWeight.w500),
      ),
    );
  }
}

class ProfileAvatar extends StatefulWidget {
  const ProfileAvatar({super.key, required this.user});

  final User? user;

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
      height: 232.w,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned.fill(
            top: 0,
            left: 0,
            right: 0,
            bottom: 40.w,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(24)),
                image: DecorationImage(image: image, fit: BoxFit.fill),
              ),
            ),
          ),
          if (widget.user != null)
            Align(
              alignment: Alignment.bottomCenter,
              child: CachedNetworkImage(
                imageUrl: widget.user!.photoURL ?? '',
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) => Container(
                  height: 80.w,
                  width: 80.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: DevfestColors.blue,
                    border: Border.all(
                        color: DevfestColors.yellowSecondary, width: 2),
                  ),
                  alignment: Alignment.center,
                  child: const Icon(Icons.error),
                ),
                imageBuilder: (context, imageProvider) => Container(
                  height: 80.w,
                  width: 80.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: DevfestColors.blue,
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.fill,
                    ),
                    border: Border.all(
                        color: DevfestColors.yellowSecondary, width: 2),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
