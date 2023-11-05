import 'package:devfest23/core/themes/colors.dart';
import 'package:devfest23/core/widgets/buttons.dart';
import 'package:devfest23/core/widgets/loading_widgets.dart';
import 'package:devfest23/features/schedule/application/application.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants.dart';
import '../../../core/icons.dart';
import '../../../core/providers/current_tab_provider.dart';
import '../../../core/router/navigator.dart';
import '../../../core/themes/theme_data.dart';
import '../../../core/ui_state_model/ui_state_model.dart';
import '../../../core/widgets/animated_indexed_stack.dart';
import '../../../core/widgets/schedule_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/enums/devfest_day.dart';
import '../../../core/router/routes.dart';
import '../../home/pages/home.dart';
import '../../home/widgets/header_delegate.dart';
import '../../home/widgets/schedule_tile.dart';

class FavouritesPage extends ConsumerStatefulWidget {
  const FavouritesPage({super.key, required this.initialDay});

  final DevfestDay initialDay;

  @override
  ConsumerState<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends ConsumerState<FavouritesPage> {
  late DevfestDay day;
  late ScrollController _scrollController;
  Map<int, double> scrollOffsets = {};

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        scrollOffsets[day.index] = _scrollController.offset;
      });

    day = widget.initialDay;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      controller: _scrollController,
      key: const PageStorageKey<String>('FavouritesPageScrollView'),
      headerSliverBuilder: (context, isScrolledUnder) {
        return [
          SliverAppBar(
            pinned: true,
            backgroundColor: DevFestTheme.of(context).backgroundColor,
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
          SliverPadding(
            padding: const EdgeInsets.only(
              left: Constants.horizontalMargin,
              right: Constants.horizontalMargin,
              bottom: Constants.largeVerticalGutter,
            ).w,
            sliver: SliverToBoxAdapter(
              child: Text.rich(
                TextSpan(
                  text: '🌟',
                  style: DevFestTheme.of(context)
                      .textTheme
                      ?.title01
                      ?.copyWith(fontWeight: FontWeight.w500),
                  children: [
                    WidgetSpan(child: 4.horizontalSpace),
                    const TextSpan(text: 'Rsvp')
                  ],
                ),
              ),
            ),
          ),
          StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SliverPersistentHeader(
                  pinned: true,
                  delegate: HeaderDelegate(
                    height: 100.w,
                    child: Container(
                      height: 100.w,
                      color: DevFestTheme.of(context).backgroundColor,
                      padding: const EdgeInsets.symmetric(
                              horizontal: Constants.horizontalMargin)
                          .w,
                      child: ScheduleTabBar(
                        index: day.index,
                        onTap: (tab) {
                          setState(() {
                            day = DevfestDay.values[tab];
                            if (scrollOffsets.containsKey(day.index)) {
                              _scrollController
                                  .jumpTo(scrollOffsets[day.index]!);
                            } else {
                              _scrollController.jumpTo(0);
                            }
                          });
                        },
                      ),
                    ),
                  ),
                );
              }

              return const SliverToBoxAdapter(child: SizedBox.shrink());
            },
          ),
        ];
      },
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            return switch (ref.watch(
                scheduleViewModelProvider.select((value) => value.viewState))) {
              ViewState.loading => const FetchingSessions(),
              ViewState.success => AnimatedIndexedStack(
                  index: day.index,
                  children: [
                    () {
                      if (ref.watch(day1RSVPSessionProvider).isEmpty) {
                        return const NoRSVPSessions();
                      }

                      return ListView.separated(
                        key: const PageStorageKey<String>('Day1'),
                        padding: const EdgeInsets.symmetric(
                                horizontal: Constants.horizontalMargin)
                            .w,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final session =
                              ref.watch(day1RSVPSessionProvider)[index];
                          return ScheduleTile(
                            isGeneral: session.category.isEmpty,
                            title: session.title,
                            speaker: session.owner,
                            time: session.scheduledDuration,
                            venue: session.hall,
                            category: session.category,
                            speakerImage: session.speakerImage,
                            hasRsvped: session.hasRsvped,
                            onTap: () {
                              context.go(RoutePaths.session, extra: session);
                            },
                          );
                        },
                        separatorBuilder: (_, __) => 14.verticalSpace,
                        itemCount: ref.watch(day1RSVPSessionProvider).length,
                      );
                    }(),
                    () {
                      if (ref.watch(day2RSVPSessionProvider).isEmpty) {
                        return const NoRSVPSessions();
                      }

                      return ListView.separated(
                        key: const PageStorageKey<String>('Day2'),
                        padding: const EdgeInsets.symmetric(
                                horizontal: Constants.horizontalMargin)
                            .w,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final session =
                              ref.watch(day2RSVPSessionProvider)[index];
                          return ScheduleTile(
                            isGeneral: session.category.isEmpty,
                            title: session.title,
                            speaker: session.owner,
                            time: session.scheduledDuration,
                            venue: session.hall,
                            category: session.category,
                            speakerImage: session.speakerImage,
                            hasRsvped: session.hasRsvped,
                            onTap: () {
                              context.go(RoutePaths.session, extra: session);
                            },
                          );
                        },
                        separatorBuilder: (_, __) => 14.verticalSpace,
                        itemCount: ref.watch(day2RSVPSessionProvider).length,
                      );
                    }(),
                  ],
                ),
              _ => const SizedBox.shrink(),
            };
          }

          return const _UserNotLoggedIn();
        },
      ),
    );
  }
}

class _UserNotLoggedIn extends StatelessWidget {
  const _UserNotLoggedIn();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const Alignment(0, -0.6),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40).w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(Constants.largeVerticalGutter).w,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: DevfestColors.grey90,
              ),
              alignment: Alignment.center,
              child: const Text(
                '🔒',
                style: TextStyle(fontSize: 32),
              ),
            ),
            Constants.largeVerticalGutter.verticalSpace,
            Text(
              'Log In To see RSVP\'d Sessions',
              textAlign: TextAlign.center,
              style: DevFestTheme.of(context).textTheme?.headline04,
            ),
            Constants.smallVerticalGutter.verticalSpace,
            Padding(
              padding: const EdgeInsets.symmetric(
                      horizontal: Constants.largeVerticalGutter)
                  .w,
              child: Text(
                'Hey Bestie! You need to be logged in to see sessions you RSVP\'d',
                textAlign: TextAlign.center,
                style: DevFestTheme.of(context).textTheme?.body03,
              ),
            ),
            Constants.largeVerticalGutter.verticalSpace,
            DevfestFilledButton(
              title: const Text('Log In Now'),
              onPressed: () {
                AppNavigator.pushNamedAndClear(RoutePaths.onboarding);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class NoRSVPSessions extends ConsumerWidget {
  const NoRSVPSessions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Align(
      alignment: const Alignment(0, -0.6),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40).w,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(Constants.largeVerticalGutter).w,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: DevfestColors.grey90,
              ),
              alignment: Alignment.center,
              child: const Text(
                '⭐',
                style: TextStyle(fontSize: 32),
              ),
            ),
            Constants.largeVerticalGutter.verticalSpace,
            Text(
              'No RSVP\'d sessions Yet',
              textAlign: TextAlign.center,
              style: DevFestTheme.of(context).textTheme?.headline04,
            ),
            Constants.smallVerticalGutter.verticalSpace,
            Padding(
              padding: const EdgeInsets.symmetric(
                      horizontal: Constants.horizontalGutter)
                  .w,
              child: Text(
                'You have not added any talk from the schedule to RSVP yet',
                textAlign: TextAlign.center,
                style: DevFestTheme.of(context).textTheme?.body03,
              ),
            ),
            Constants.largeVerticalGutter.verticalSpace,
            DevfestFilledButton(
              title: const Text('View Schedule'),
              onPressed: () {
                ref.watch(appCurrentTab.notifier).update((state) => state = 1);
                pageController.animateTo(1);
              },
            ),
          ],
        ),
      ),
    );
  }
}
