import 'package:devfest23/core/enums/devfest_day.dart';
import 'package:devfest23/features/home/pages/agenda.dart';
import 'package:devfest23/features/home/pages/favourites.dart';
import 'package:devfest23/features/home/pages/more.dart';
import 'package:devfest23/features/home/pages/schedule.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/enums/tab_item.dart';
import '../../../core/themes/themes.dart';
import '../../../core/widgets/widgets.dart';

class AppHome extends ConsumerStatefulWidget {
  const AppHome({
    super.key,
    this.initialTab = TabItem.home,
    this.initialDay = DevfestDay.day1,
  });

  final TabItem initialTab;
  final DevfestDay initialDay;

  @override
  ConsumerState<AppHome> createState() => _AppHomeState();
}

class _AppHomeState extends ConsumerState<AppHome> {
  late final _pages = [
    AgendaPage(initialDay: widget.initialDay),
    SchedulePage(initialDay: widget.initialDay),
    const SizedBox(),
    FavouritesPage(initialDay: widget.initialDay),
    const MorePage(),
  ];

  int index = 0;

  @override
  void initState() {
    super.initState();
    index = widget.initialTab.index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DevFestTheme.of(context).backgroundColor,
      body: IndexedStack(
        index: index,
        children: _pages,
      ),
      bottomNavigationBar: DevfestBottomNav(
        index: index,
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
          setState(() => index = page);
        },
      ),
    );
  }
}
