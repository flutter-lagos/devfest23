import 'package:devfest23/core/ui_state_model/ui_state_model.dart';
import 'package:devfest23/features/schedule/application/controllers.dart';
import 'package:devfest23/features/schedule/application/sessions/view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/enums/devfest_day.dart';
import '../../../core/router/navigator.dart';
import '../../../core/router/routes.dart';
import '../../../core/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants.dart';
import '../../../core/icons.dart';
import '../../../core/themes/themes.dart';
import '../../../core/widgets/schedule_tab_bar.dart';
import '../../home/widgets/header_delegate.dart';
import '../../home/widgets/schedule_tile.dart';

class SchedulePage extends ConsumerStatefulWidget {
  const SchedulePage({super.key, required this.initialDay});

  final DevfestDay initialDay;

  @override
  ConsumerState<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends ConsumerState<SchedulePage> {
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
      physics: const AlwaysScrollableScrollPhysics(),
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
                  text: '🕧',
                  style: DevFestTheme.of(context).textTheme?.title01,
                  children: [
                    WidgetSpan(child: 4.horizontalSpace),
                    const TextSpan(text: 'Schedule')
                  ],
                ),
              ),
            ),
          ),
          SliverPersistentHeader(
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
                        _scrollController.jumpTo(scrollOffsets[day.index]!);
                      } else {
                        _scrollController.jumpTo(0);
                      }
                    });
                  },
                ),
              ),
            ),
          ),
        ];
      },
      body: () {
        if (ref.watch(
                scheduleViewModelProvider.select((value) => value.viewState)) ==
            ViewState.loading) {
          return Padding(
            padding: const EdgeInsets.symmetric(
                    horizontal: Constants.horizontalMargin)
                .w,
            child: const FetchingSessions(),
          );
        }

        return AnimatedIndexedStack(
          index: day.index,
          children: [
            ListView.separated(
              key: const PageStorageKey<String>('Day1'),
              padding: const EdgeInsets.symmetric(
                horizontal: Constants.horizontalMargin,
              ).w,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final session = ref.watch(day1SessionsProvider)[index];
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
              itemCount: ref.watch(day1SessionsProvider).length,
            ),
            ListView.separated(
              key: const PageStorageKey<String>('Day2'),
              padding: const EdgeInsets.symmetric(
                      horizontal: Constants.horizontalMargin)
                  .w,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final session = ref.watch(day2SessionsProvider)[index];
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
              itemCount: ref.watch(day2SessionsProvider).length,
            ),
          ],
        );
      }(),
    );
  }
}
