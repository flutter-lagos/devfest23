import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/enums/tab_item.dart';
import '../../../core/providers/current_tab_provider.dart';
import '../../../core/themes/themes.dart';
import '../../../core/widgets/widgets.dart';
import '../../agenda/pages/agenda_base.dart';
import '../../favourites/pages/favourites_base.dart';
import '../../more/pages/more_base.dart';
import '../../schedule/pages/schedule_base.dart';
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
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DevFestTheme.of(context).backgroundColor,
      body: TabBarView(
        // physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: const [
          AgendaView(),
          ScheduleView(),
          SpeakersView(),
          FavouritesView(),
          MoreView(),
        ],
      ),
      bottomNavigationBar: DevfestBottomNav(
        index: ref.watch(appCurrentTab),
        items: const [
          DevfestBottomNavItem(label: 'Home', icon: Icon(Icons.home_filled)),
          DevfestBottomNavItem(
            label: 'Schedule',
            icon: Icon(Icons.checklist_rtl_rounded),
          ),
          DevfestBottomNavItem(
              label: 'Speakers', icon: Icon(Icons.person_2_rounded)),
          DevfestBottomNavItem(
            label: 'Favourites',
            icon: Icon(Icons.star_border_rounded),
          ),
          DevfestBottomNavItem(
            label: 'More',
            icon: Icon(Icons.more_rounded, size: 18),
            inactiveIcon: Icon(Icons.more_rounded),
          ),
        ],
        onTap: (page) {
          pageController.index = page;
          ref.watch(appCurrentTab.notifier).update((state) => state = page);
        },
      ),
    );
  }
}
