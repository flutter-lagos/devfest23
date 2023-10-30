import 'package:devfest23/features/favourites/application/view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/enums/tab_item.dart';
import '../../../core/providers/current_tab_provider.dart';
import '../../../core/themes/themes.dart';
import '../../../core/widgets/widgets.dart';
import '../../agenda/pages/agenda_base.dart';
import '../../favourites/pages/favourites_base.dart';
import '../../more/pages/more_base.dart';
import '../../schedule/application/sessions/view_model.dart';
import '../../schedule/pages/schedule_base.dart';
import '../../speakers/application/application.dart';
import '../../speakers/page/speakers_base.dart';

late final TabController pageController;

class AppHome extends ConsumerStatefulWidget {
  const AppHome({
    super.key,
    this.tab = TabItem.home,
  });

  final TabItem tab;

  @override
  ConsumerState<AppHome> createState() => _AppHomeState();
}

class _AppHomeState extends ConsumerState<AppHome>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    pageController =
        TabController(initialIndex: widget.tab.index, length: 5, vsync: this);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref
          .watch(appCurrentTab.notifier)
          .update((state) => state = widget.tab.index);
      _userInfoCalls();
    });

    super.initState();
  }

  Future _userInfoCalls() {
    return Future.wait([
      ref.read(scheduleViewModelProvider.notifier).fetchSessions(),
      ref.read(speakersViewModelProvider.notifier).fetchSpeakers(),
      ref.read(speakersViewModelProvider.notifier).fetchSessionCategories(),
      ref.read(rsvpSessionsViewModelProvider.notifier).fetchRSVPSessions(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        backgroundColor: DevFestTheme.of(context).backgroundColor,
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          children: const [
            AgendaView(),
            ScheduleView(),
            SpeakersView(),
            FavouritesView(),
            MoreView(),
          ],
        ),
        floatingActionButton: ref.watch(appCurrentTab) == 4
            ? null
            : FloatingActionButton(
                tooltip: 'refresh button',
                onPressed: _userInfoCalls,
                backgroundColor:
                    DevFestTheme.of(context).inverseBackgroundColor,
                child: Icon(
                  Icons.refresh_rounded,
                  color: DevFestTheme.of(context).backgroundColor,
                ),
              ),
        bottomNavigationBar: DevfestBottomNav(
          index: ref.watch(appCurrentTab),
          items: const [
            DevfestBottomNavItem(
                label: 'Home', icon: Icon(Icons.home_outlined)),
            DevfestBottomNavItem(
              label: 'Schedule',
              icon: Icon(Icons.checklist_rtl_outlined),
            ),
            DevfestBottomNavItem(
                label: 'Speakers', icon: Icon(Icons.person_2_outlined)),
            DevfestBottomNavItem(
              label: 'Favourites',
              icon: Icon(Icons.star_border_outlined),
            ),
            DevfestBottomNavItem(
              label: 'More',
              icon: Icon(Icons.more_rounded, size: 18),
              inactiveIcon: Icon(Icons.more_outlined),
            ),
          ],
          onTap: (page) {
            pageController.index = page;
            ref.watch(appCurrentTab.notifier).update((state) => state = page);
          },
        ),
      ),
    );
  }
}
