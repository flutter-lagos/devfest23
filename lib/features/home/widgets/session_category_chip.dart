import 'package:flutter/material.dart';

import '../../../core/constants.dart';
import '../../../core/themes/themes.dart';

import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../../core/widgets/widgets.dart';

@widgetbook.UseCase(
    name: 'Session category chip',
    type: DevfestSessionCatChips,
    designLink:
        'https://www.figma.com/file/CCnX5Sh86ILqRn7ng6Shlr/DevFest-Jordan-Year---Mobile-App?node-id=1591%3A1213&mode=dev')
Widget devfestSessionCatChip(BuildContext context) {
  const selectedTab = 'All Speakers';
  return Material(
    color: DevFestTheme.of(context).backgroundColor,
    child: SizedBox(
      height: MediaQuery.sizeOf(context).height,
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: Constants.horizontalMargin),
        child: Center(
          child: Row(
            children: [
              SessionCategoryChip(
                selectedTab: selectedTab,
                tab: 'All Speakers',
              ),
              SizedBox(width: 8),
              SessionCategoryChip(
                selectedTab: selectedTab,
                tab: 'Mobile Development',
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class SessionCategoryChip extends StatelessWidget {
  const SessionCategoryChip({
    super.key,
    required this.selectedTab,
    required this.tab,
    this.onTap,
  });

  final String selectedTab;
  final String tab;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        height: 38,
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: ShapeDecoration(
          color: tab == selectedTab
              ? const Color(0xFF0F0E0E)
              : DevfestColors.background,
          shape: RoundedRectangleBorder(
            side: tab == selectedTab
                ? BorderSide.none
                : const BorderSide(width: 0.50, color: DevfestColors.grey60),
            borderRadius: BorderRadius.circular(48),
          ),
        ),
        child: Center(
          child: Text(
            tab,
            style: DevFestTheme.of(context).textTheme?.body03?.copyWith(
                  color: tab == selectedTab
                      ? DevfestColors.grey90
                      : DevfestColors.grey60,
                ),
          ),
        ),
      ),
    );
  }
}
