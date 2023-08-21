import 'package:devfest23/core/enums/devfest_day.dart';
import 'package:devfest23/core/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/enums/tab_item.dart';
import '../../../core/themes/themes.dart';
import '../../../core/widgets/widgets.dart';

class AppHome extends ConsumerStatefulWidget {
  const AppHome({
    super.key,
    this.tab = TabItem.home,
    this.day = DevfestDay.day1,
    required this.child,
  });

  final TabItem tab;
  final DevfestDay day;
  final Widget child;

  @override
  ConsumerState<AppHome> createState() => _AppHomeState();
}

class _AppHomeState extends ConsumerState<AppHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DevFestTheme.of(context).backgroundColor,
      body: widget.child,
      bottomNavigationBar: DevfestBottomNav(
        index: widget.tab.index,
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
          if (TabItem.values[page] == widget.tab) return;

          context.goNamed(
            RouteNames.home,
            pathParameters: {
              'tab': TabItem.values[page].name,
              'day': widget.day.name,
            },
          );
        },
      ),
    );
  }
}
