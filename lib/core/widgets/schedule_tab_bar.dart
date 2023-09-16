import 'package:devfest23/core/constants.dart';
import 'package:devfest23/core/themes/colors.dart';
import 'package:devfest23/core/themes/theme_data.dart';
import 'package:devfest23/core/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../providers/providers.dart';

@widgetbook.UseCase(name: 'Schedule Tabs', type: DevfestTabs)
Widget devfestTab(BuildContext context) {
  int index = 0;
  return Material(
    color: DevFestTheme.of(context).backgroundColor,
    child: StatefulBuilder(
      builder: (context, setState) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScheduleTabBar(
              index: index,
              onTap: (tab) {
                setState(() => index = tab);
              },
            ),
          ],
        );
      },
    ),
  );
}

class ScheduleTabBar extends StatelessWidget {
  const ScheduleTabBar({
    super.key,
    required this.index,
    required this.onTap,
  });

  final int index;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 4,
              child: _TabTile(
                text: 'Day 1',
                selected: index == 0,
                onTap: () {
                  HapticFeedback.lightImpact();
                  onTap.call(0);
                },
              ),
            ),
            const Flexible(child: SizedBox(width: double.infinity)),
            Expanded(
              flex: 4,
              child: _TabTile(
                text: 'Day 2',
                selected: index == 1,
                onTap: () {
                  HapticFeedback.lightImpact();
                  onTap.call(1);
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: Constants.verticalGutter),
        _DateTile(index == 0 ? DateTime(2023, 11, 24) : DateTime(2023, 11, 25)),
      ],
    );
  }
}

class _DateTile extends StatelessWidget {
  const _DateTile(this.date);

  final DateTime date;

  static final _dateFormat = DateFormat('MMMM, yyyy');
  static final _dayFormat = DateFormat('dd');

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Constants.horizontalGutter * 2,
        vertical: 6,
      ),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(24)),
        color: DevfestColors.yellowSecondary,
      ),
      child: Text(
        '${_dayFormat.format(date)}${nthNumber(date.day)} ${_dateFormat.format(date)}',
        style: DevFestTheme.of(context)
            .textTheme
            ?.body04
            ?.copyWith(color: DevfestColors.grey10),
      ),
    );
  }

  String nthNumber(int day) {
    if (day > 3 && day < 21) return 'th';
    return switch (day % 10) {
      1 => 'st',
      2 => 'nd',
      3 => 'rd',
      _ => 'th',
    };
  }
}

class _TabTile extends ConsumerWidget {
  const _TabTile({
    required this.text,
    required this.selected,
    this.onTap,
  });

  final String text;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context, ref) {
    return AnimatedDefaultTextStyle(
      style: DevFestTheme.of(context).textTheme!.title01!.copyWith(
        color: () {
          if (selected) return DevFestTheme.of(context).onBackgroundColor;
          return ref.watch(isDarkProvider)
              ? DevfestColors.grey70
              : DevfestColors.grey40;
        }(),
      ),
      duration: Constants.kAnimationDur,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              text,
              style: DevFestTheme.of(context).textTheme?.title02,
            ),
            const SizedBox(height: Constants.smallVerticalGutter),
            AnimatedContainer(
              duration: Constants.kAnimationDur,
              height: 3,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                color: () {
                  if (selected) {
                    return ref.watch(isDarkProvider)
                        ? DevfestColors.grey100
                        : DevfestColors.grey0;
                  }
                }(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
