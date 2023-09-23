import 'package:devfest23/core/widgets/chips.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../core/constants.dart';
import '../../../core/themes/themes.dart';
import '../../../core/widgets/widgets.dart';

enum SessionStatus { notStarted, ongoing, completed }

class SessionInfo {
  final String title;
  final String host;
  final int slotsLeft;
  final String venue;
  final DateTime sessionTime;
  final bool isGeneralSession;
  final String description;
  final SessionStatus status;

  const SessionInfo({
    required this.title,
    required this.host,
    required this.slotsLeft,
    required this.venue,
    required this.sessionTime,
    required this.isGeneralSession,
    required this.description,
    required this.status,
  });
}

class SessionPage extends StatefulWidget {
  const SessionPage({super.key});

  @override
  State<SessionPage> createState() => _SessionPageState();
}

class _SessionPageState extends State<SessionPage> {
  static SessionInfo get _speakerSession => SessionInfo(
        title: 'Understanding the importance of creativity',
        host: 'Aise Idahor',
        venue: 'Hall A',
        slotsLeft: 100,
        sessionTime: DateTime.now().subtract(const Duration(minutes: 30)),
        isGeneralSession: false,
        description:
            'Wake up to reality! Nothing ever goes as planned in this accursed world. The longer you live, the more you realize that the only things that truly exist in this reality are merely pain, suffering and futility. Listen, everywhere you look in this world, wherever there is light, there will always be shadows to be found as well.',
        status: SessionStatus.completed,
      );

  @override
  Widget build(BuildContext context) {
    final session = _speakerSession;
    return Scaffold(
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
        child: session.isGeneralSession
            ? GeneralSessionPage(info: session)
            : SpeakerSessionPage(info: session),
      ),
    );
  }
}

class GeneralSessionPage extends StatelessWidget {
  const GeneralSessionPage({super.key, required this.info});

  final SessionInfo info;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (info.status != SessionStatus.notStarted) ...[
            _SessionStatus(status: info.status),
            Constants.largeVerticalGutter.verticalSpace,
          ],
          _TitleSection(info: info),
          Padding(
            padding: const EdgeInsets.symmetric(
                    vertical: Constants.largeVerticalGutter)
                .w,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SessionTimeChip(sessionTime: info.sessionTime),
                Constants.horizontalGutter.verticalSpace,
                SessionVenueChip(venue: info.venue),
              ],
            ),
          ),
          _DescriptionSection(info: info),
        ],
      ),
    );
  }
}

class SpeakerSessionPage extends StatefulWidget {
  const SpeakerSessionPage({super.key, required this.info});

  final SessionInfo info;

  @override
  State<SpeakerSessionPage> createState() => _SpeakerSessionPageState();
}

class _SpeakerSessionPageState extends State<SpeakerSessionPage> {
  bool isFavourite = false;

  @override
  Widget build(BuildContext context) {
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
                    SessionTimeLeftChip(
                      minuteLeft: DateTime.now()
                          .difference(widget.info.sessionTime)
                          .inMinutes,
                    ),
                    SessionSlotsChip(slotsLeft: widget.info.slotsLeft),
                  ],
                ),
                Constants.largeVerticalGutter.verticalSpace,
                _TitleSection(info: widget.info),
                Padding(
                  padding: const EdgeInsets.symmetric(
                          vertical: Constants.largeVerticalGutter)
                      .w,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SessionTimeChip(sessionTime: widget.info.sessionTime),
                      Constants.horizontalGutter.horizontalSpace,
                      SessionVenueChip(venue: widget.info.venue),
                      if (widget.info.status != SessionStatus.notStarted) ...[
                        Constants.horizontalGutter.horizontalSpace,
                        _SessionStatus(status: widget.info.status),
                      ],
                    ],
                  ),
                ),
                _DescriptionSection(info: widget.info),
              ],
            ),
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.symmetric(vertical: Constants.verticalGutter).w,
          child: _FavouriteInfoText(isFavourite: isFavourite),
        ),
        DevfestFavouriteButton(
          isFavourite: isFavourite,
          onPressed: () {
            setState(() {
              isFavourite = !isFavourite;
            });
          },
        ),
        Constants.largeVerticalGutter.verticalSpace,
      ],
    );
  }
}

class _TitleSection extends StatelessWidget {
  const _TitleSection({required this.info});

  final SessionInfo info;

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
            Container(
              height: 32.w,
              width: 32.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: DevfestColors.green, width: 2),
              ),
            ),
            Constants.horizontalGutter.horizontalSpace,
            Text(
              info.host,
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

  final SessionInfo info;

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

class _SessionStatus extends StatelessWidget {
  const _SessionStatus({required this.status});

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
