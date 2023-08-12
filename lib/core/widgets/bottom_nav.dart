import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../constants.dart';
import '../themes/themes.dart';

@widgetbook.UseCase(name: 'Devfest Bottom Nav', type: DevfestBottomNav)
Widget devfestBottomNav(BuildContext context) {
  int index = 0;
  return StatefulBuilder(builder: (context, setState) {
    return Scaffold(
      backgroundColor: DevFestTheme.of(context).backgroundColor,
      bottomNavigationBar: DevfestBottomNav(
        index: index,
        items: const [
          DevfestBottomNavItem(label: 'Home', icon: Icon(Icons.home_filled)),
          DevfestBottomNavItem(
            label: 'Schedule',
            icon: Icon(Icons.schedule_rounded),
          ),
          DevfestBottomNavItem(label: 'Speakers', icon: Icon(Icons.speaker)),
          DevfestBottomNavItem(
            label: 'Favourites',
            icon: Icon(Icons.star_border_purple500_outlined),
          ),
          DevfestBottomNavItem(
            label: 'More',
            icon: Icon(Icons.airplane_ticket_rounded),
          ),
        ],
        onTap: (page) {
          setState(() => index = page);
        },
      ),
    );
  });
}

class DevfestBottomNav extends StatefulWidget {
  const DevfestBottomNav({
    super.key,
    required this.index,
    required this.onTap,
    required this.items,
    this.selectedColor,
    this.unselectedColor,
    this.labelStyle,
  });

  final ValueChanged<int> onTap;
  final int index;
  final List<DevfestBottomNavItem> items;
  final Color? selectedColor;
  final Color? unselectedColor;
  final TextStyle? labelStyle;

  @override
  State<DevfestBottomNav> createState() => _DevfestBottomNavState();
}

class _DevfestBottomNavState extends State<DevfestBottomNav> {
  @override
  Widget build(BuildContext context) {
    return DevfestTheme(
      data: DevFestTheme.of(context).copyWith(
        bottomNavTheme: DevFestTheme.of(context).bottomNavTheme?.copyWith(
              labelStyle: widget.labelStyle,
              selectedColor: widget.selectedColor,
              unselectedColor: widget.unselectedColor,
            ),
      ),
      child: SizedBox(
        height: 88 + MediaQuery.paddingOf(context).bottom,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            widget.items.length,
            (index) => _DevfestBottomNavTile(
              icon: widget.items[index].icon,
              label: widget.items[index].label,
              selected: widget.index == index,
              onTap: () {
                widget.onTap.call(index);
              },
            ),
          ),
        ),
      ),
    );
  }
}

class DevfestBottomNavItem {
  final String label;
  final Widget icon;

  const DevfestBottomNavItem({
    required this.label,
    required this.icon,
  });
}

class _DevfestBottomNavTile extends StatelessWidget {
  const _DevfestBottomNavTile({
    required this.icon,
    required this.label,
    this.selected = false,
    required this.onTap,
  });

  final String label;
  final Widget icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final bottomNavItemTheme = DevFestTheme.of(context).bottomNavTheme ??
        const DevfestBottomNavTheme.light();

    final itemColor = selected
        ? bottomNavItemTheme.selectedColor
        : bottomNavItemTheme.unselectedColor;
    return InkWell(
      onTap: onTap,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 70),
        child: AnimatedDefaultTextStyle(
          duration: Constants.kAnimationDur,
          style: bottomNavItemTheme.labelStyle.copyWith(color: itemColor),
          child: IconTheme(
            data: IconThemeData(size: 24, color: itemColor),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: selected
                      ? Column(
                          key: const Key('selected icon'),
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 30,
                              width: 30,
                              decoration: ShapeDecoration(
                                shape: const CircleBorder(),
                                color: itemColor.withOpacity(0.4),
                              ),
                              alignment: Alignment.center,
                              child: icon,
                            ),
                            const SizedBox(height: 2),
                          ],
                        )
                      : Column(
                          key: const Key('unselected icon'),
                          mainAxisSize: MainAxisSize.min,
                          children: [icon, const SizedBox(height: 8)],
                        ),
                ),
                Text(
                  label,
                  style: bottomNavItemTheme.labelStyle,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
