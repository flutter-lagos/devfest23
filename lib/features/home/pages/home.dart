import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/router/router.dart';
import '../../../core/themes/themes.dart';
import '../../../core/widgets/widgets.dart';

class AppHome extends ConsumerStatefulWidget {
  const AppHome({super.key, this.initialTab = TabItem.home});

  final TabItem initialTab;

  @override
  ConsumerState<AppHome> createState() => _AppHomeState();
}

class _AppHomeState extends ConsumerState<AppHome> {
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
            icon: Icon(Icons.more_rounded, size: 16),
          ),
        ],
        onTap: (page) {
          setState(() => index = page);
        },
      ),
    );
  }
}
