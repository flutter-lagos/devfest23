import 'package:cached_network_image/cached_network_image.dart';
import 'package:devfest23/core/data/data.dart';
import 'package:devfest23/core/ui_state_model/ui_state_model.dart';
import 'package:devfest23/features/schedule/application/application.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/icons.dart';
import '../../../core/router/navigator.dart';
import '../../../core/router/routes.dart';
import '../../../core/widgets/chips.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../core/constants.dart';
import '../../../core/themes/themes.dart';
import '../../../core/widgets/widgets.dart';

enum SessionStatus { notStarted, ongoing, completed }

class SessionPage extends ConsumerStatefulWidget {
  const SessionPage({super.key, required this.session});

  final Session session;

  @override
  ConsumerState<SessionPage> createState() => _SessionPageState();
}

class _SessionPageState extends ConsumerState<SessionPage> {
  @override
  void initState() {
    super.initState();

    ref.listenManual(
      sessionDetailsViewModelProvider.select((value) => value.viewState),
      (previous, next) {
        if (next == ViewState.success) {
          ref.read(scheduleViewModelProvider.notifier).fetchSessions();
        }
      },
    );

    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) {
      ref
          .read(sessionDetailsViewModelProvider.notifier)
          .initialiseSession(widget.session);
    });
  }

  @override
  Widget build(BuildContext context) {
    return OnScreenLoader(
      isLoading: ref.watch(sessionDetailsViewModelProvider
              .select((value) => value.viewState)) ==
          ViewState.loading,
      child: Scaffold(
        backgroundColor: DevFestTheme.of(context).backgroundColor,
        appBar: AppBar(
          backgroundColor: DevFestTheme.of(context).backgroundColor,
          elevation: 0,
          leadingWidth: 120,
          scrolledUnderElevation: 0,
          leading: const GoBackButton(),
        ),
        body: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: Constants.horizontalMargin)
                  .w,
          child: ref.watch(sessionProvider).sessionId.isEmpty
              ? GeneralSessionPage(info: ref.watch(sessionProvider))
              : SpeakerSessionPage(info: ref.watch(sessionProvider)),
        ),
      ),
    );
  }
}

class GeneralSessionPage extends StatelessWidget {
  const GeneralSessionPage({super.key, required this.info});

  final Session info;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _TitleSection(info: info),
          Padding(
            padding: const EdgeInsets.symmetric(
                    vertical: Constants.largeVerticalGutter)
                .w,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // SessionTimeChip(sessionTime: info.sessionTime),
                Constants.horizontalGutter.verticalSpace,
                SessionVenueChip(venue: info.hall),
              ],
            ),
          ),
          _DescriptionSection(info: info),
        ],
      ),
    );
  }
}

class SpeakerSessionPage extends ConsumerWidget {
  const SpeakerSessionPage({super.key, required this.info});

  final Session info;

  @override
  Widget build(BuildContext context, ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SessionSlotsChip(slotsLeft: info.availableSeats),
                  ],
                ),
                Constants.largeVerticalGutter.verticalSpace,
                _TitleSection(info: info),
                Padding(
                  padding: const EdgeInsets.symmetric(
                          vertical: Constants.largeVerticalGutter)
                      .w,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SessionTimeChip(sessionTime: info.scheduledAt),
                      Constants.horizontalGutter.horizontalSpace,
                      SessionVenueChip(venue: info.hall),
                    ],
                  ),
                ),
                _DescriptionSection(info: info),
              ],
            ),
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.symmetric(vertical: Constants.verticalGutter).w,
          child: _FavouriteInfoText(isFavourite: info.hasRsvped),
        ),
        StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              return DevfestFavouriteButton(
                isFavourite: info.hasRsvped,
                onPressed: ref
                    .read(sessionDetailsViewModelProvider.notifier)
                    .reserveSessionOnTap,
              );
            }
            return DevfestLoginReserveSessionButton(
              onPressed: () {
                AppNavigator.pushNamedAndClear(RoutePaths.onboarding);
              },
            );
          },
        ),
        Constants.largeVerticalGutter.verticalSpace,
      ],
    );
  }
}

class _TitleSection extends StatelessWidget {
  const _TitleSection({required this.info});

  final Session info;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          info.title,
          textAlign: TextAlign.start,
          style: DevFestTheme.of(context)
              .textTheme
              ?.headline03
              ?.copyWith(height: 1),
        ),
        Padding(
          padding:
              const EdgeInsets.symmetric(vertical: Constants.verticalGutter).w,
          child: Text(
            'HOST',
            style:
                DevFestTheme.of(context).textTheme?.body04?.copyWith(height: 1),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CachedNetworkImage(
              imageUrl: info.speakerImage,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(value: downloadProgress.progress),
              errorWidget: (context, url, error) => Container(
                height: 32.w,
                width: 32.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    strokeAlign: BorderSide.strokeAlignOutside,
                    color: DevfestColors.green,
                    width: 2,
                  ),
                ),
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  AppIcons.devfestLogo,
                  height: 10.w,
                  fit: BoxFit.contain,
                ),
              ),
              imageBuilder: (context, imageProvider) => Container(
                height: 32.w,
                width: 32.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    strokeAlign: BorderSide.strokeAlignOutside,
                    color: DevfestColors.green,
                    width: 2,
                  ),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Constants.horizontalGutter.horizontalSpace,
            Text(
              info.owner,
              style: DevFestTheme.of(context)
                  .textTheme
                  ?.body02
                  ?.copyWith(fontWeight: FontWeight.w500),
            )
          ],
        ),
      ],
    );
  }
}

class _DescriptionSection extends StatelessWidget {
  const _DescriptionSection({required this.info});

  final Session info;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'DESCRIPTION',
          style: DevFestTheme.of(context)
              .textTheme
              ?.body04
              ?.copyWith(fontWeight: FontWeight.w500),
        ),
        Constants.smallVerticalGutter.verticalSpace,
        Text(
          info.description,
          textAlign: TextAlign.start,
          style: DevFestTheme.of(context).textTheme?.body03?.copyWith(),
        ),
      ],
    );
  }
}

class SessionStatusWidget extends StatelessWidget {
  const SessionStatusWidget({super.key, required this.status});

  final SessionStatus status;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Constants.kAnimationDur,
      child: Align(
        alignment: Alignment.centerLeft,
        child: switch (status) {
          SessionStatus.ongoing => const SessionStatusChip(isOngoing: true),
          SessionStatus.completed => const SessionStatusChip(isOngoing: false),
          _ => const SizedBox.shrink(),
        },
      ),
    );
  }
}

class _FavouriteInfoText extends StatelessWidget {
  const _FavouriteInfoText({required this.isFavourite});

  final bool isFavourite;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Constants.kAnimationDur,
      child: () {
        if (isFavourite) return const SizedBox.shrink();

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Symbols.error,
              color: DevfestColors.yellow,
              weight: Constants.iconWeight,
            ),
            Constants.horizontalGutter.horizontalSpace,
            Expanded(
              child: Text(
                'Save your spot for this talk by adding it to favourites',
                style: DevFestTheme.of(context)
                    .textTheme
                    ?.body03
                    ?.copyWith(fontWeight: FontWeight.w500),
              ),
            ),
          ],
        );
      }(),
    );
  }
}
