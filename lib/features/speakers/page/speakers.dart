import 'package:devfest23/core/ui_state_model/ui_state_model.dart';

import '../../../core/router/navigator.dart';
import '../../../core/router/routes.dart';
import '../../home/widgets/speakers_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants.dart';
import '../../../core/enums/devfest_day.dart';
import '../../../core/icons.dart';
import '../../../core/themes/themes.dart';
import '../../../core/widgets/schedule_tab_bar.dart';
import '../../../core/widgets/widgets.dart';
import '../../home/widgets/header_delegate.dart';
import '../../home/widgets/session_category_chip.dart';
import '../application/application.dart';

class SpeakersPage extends ConsumerStatefulWidget {
  const SpeakersPage({super.key, required this.initialDay});

  final DevfestDay initialDay;

  @override
  ConsumerState<SpeakersPage> createState() => _SpeakersPageState();
}

class _SpeakersPageState extends ConsumerState<SpeakersPage> {
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
      key: const PageStorageKey<String>('SpeakersPageScrollView'),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      text: '🎤',
                      style: DevFestTheme.of(context)
                          .textTheme
                          ?.title01
                          ?.copyWith(fontWeight: FontWeight.w500),
                      children: [
                        WidgetSpan(child: 4.horizontalSpace),
                        const TextSpan(text: 'Speakers')
                      ],
                    ),
                  ),
                  const SizedBox(height: Constants.largeVerticalGutter),
                  SizedBox(
                    height: 38.h,
                    child: const _Categories(),
                  )
                ],
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
                speakersViewModelProvider.select((value) => value.viewState)) ==
            ViewState.loading) {
          return const FetchingSpeakers();
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
                var color = [
                  const Color(0xfff6eeee),
                  DevfestColors.greenSecondary,
                  DevfestColors.blueSecondary,
                  const Color(0xffffafff)
                ].elementAt(index > 3 ? index % 2 : index);

                final speaker = ref.watch(speakersProvider)[index];
                return SpeakersChip(
                  moodColor: color,
                  name: speaker.name,
                  shortInfo: speaker.role,
                  avatarImageUrl: speaker.avatar,
                  onTap: () {
                    context.go('${RoutePaths.speakers}/$index');
                  },
                );
              },
              separatorBuilder: (_, __) => const SizedBox(height: 14),
              itemCount: ref.watch(speakersProvider).length,
            ),
            ListView.separated(
              key: const PageStorageKey<String>('Day2'),
              padding: const EdgeInsets.symmetric(
                  horizontal: Constants.horizontalMargin),
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                var color = [
                  const Color(0xfff6eeee),
                  DevfestColors.greenSecondary,
                  DevfestColors.blueSecondary,
                  const Color(0xffffafff)
                ].elementAt(index > 3 ? index % 2 : index);

                final speaker = ref.watch(speakersProvider)[index];
                return SpeakersChip(
                  moodColor: color,
                  name: speaker.name,
                  shortInfo: speaker.role,
                  avatarImageUrl: speaker.avatar,
                  onTap: () {
                    context.go('${RoutePaths.speakers}/$index');
                  },
                );
              },
              separatorBuilder: (_, __) => const SizedBox(height: 14),
              itemCount: ref.watch(speakersProvider).length,
            ),
          ],
        );
      }(),
    );
  }
}

class _Categories extends ConsumerWidget {
  const _Categories();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return switch (ref.watch(speakersViewModelProvider
        .select((value) => value.categoriesUiState.viewState))) {
      ViewState.loading => const FetchCategories(),
      _ => ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            if (index == 0) {
              return SessionCategoryChip(
                selectedTab: ref.watch(speakersViewModelProvider
                    .select((value) => value.selectedCategory)),
                tab: 'All Speakers',
                onTap: () {
                  ref
                      .read(speakersViewModelProvider.notifier)
                      .filterSpeakersByCategory('All Speakers');
                },
              );
            }
            final category = ref.watch(categoriesProvider)[index - 1];
            return SessionCategoryChip(
              tab: category.name,
              selectedTab: ref.watch(speakersViewModelProvider
                  .select((value) => value.selectedCategory)),
              onTap: () {
                ref
                    .read(speakersViewModelProvider.notifier)
                    .filterSpeakersByCategory(category.name);
              },
            );
          },
          separatorBuilder: (context, index) => 8.horizontalSpace,
          itemCount: ref.watch(categoriesProvider).length + 1,
        ),
    };
  }
}
