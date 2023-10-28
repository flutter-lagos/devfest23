import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../features/home/widgets/schedule_tile.dart';
import '../../features/home/widgets/session_category_chip.dart';
import '../../features/home/widgets/speakers_chip.dart';
import '../constants.dart';
import '../themes/themes.dart';

class FetchingSessions extends StatelessWidget {
  const FetchingSessions({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (context, index) => const ScheduleTileShimmer(),
      separatorBuilder: (_, __) => const SizedBox(height: 14),
      itemCount: 5,
    );
  }
}

class FetchingSpeakers extends StatelessWidget {
  const FetchingSpeakers({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      padding:
          const EdgeInsets.symmetric(horizontal: Constants.horizontalMargin),
      itemBuilder: (context, index) {
        var color = [
          const Color(0xfff6eeee),
          DevfestColors.greenSecondary,
          DevfestColors.blueSecondary,
          const Color(0xffffafff)
        ].elementAt(index > 3 ? 3 : index);
        return SpeakerShimmerChip(moodColor: color);
      },
      separatorBuilder: (_, __) => const SizedBox(height: 14),
      itemCount: 5,
    );
  }
}

class FetchCategories extends StatelessWidget {
  const FetchCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemBuilder: (_, __) => const SessionCategoryShimmerChip(),
      separatorBuilder: (context, index) => 8.horizontalSpace,
      itemCount: 8,
    );
  }
}
