import 'package:devfest23/core/constants.dart';
import 'package:devfest23/core/themes/themes.dart';
import 'package:devfest23/core/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' hide Text, List, Radius;

import '../../../core/providers/providers.dart';
import '../widgets/speaker_action_card.dart';

class SpeakerDetailsPage extends ConsumerWidget {
  const SpeakerDetailsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(isDarkProvider);
    final theme = DevFestTheme.of(context);
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: theme.backgroundColor,
        surfaceTintColor: theme.backgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        leadingWidth: 120,
        leading: const GoBackButton(),
        iconTheme: IconThemeData(
            color: isDark ? DevfestColors.background : DevfestColors.grey0),
        titleTextStyle: theme.textTheme?.button
            ?.copyWith(color: Theme.of(context).textTheme.bodyMedium?.color),
        titleSpacing: 0,
      ),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 24).w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 148.h,
                child: Row(
                  children: [
                    const SpeakerAvatar(),
                    12.horizontalSpace,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Iyinoluwa Ogundairo',
                            style: theme.textTheme?.title02,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          8.verticalSpace,
                          Text(
                            'Mobile Developer, Skype',
                            style: theme.textTheme?.body03?.copyWith(
                                color: isDark
                                    ? DevfestColors.grey80
                                    : DevfestColors.grey30),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          16.verticalSpace,
                          Row(
                            children: <StatelessWidget>[
                              const Twitter(),
                              const LinkedIn(),
                              const Link()
                            ]
                                .map(
                                  (icon) => Container(
                                    width: 32.w,
                                    height: 32.w,
                                    padding: const EdgeInsets.all(8).w,
                                    margin: const EdgeInsets.only(right: 8).w,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: ShapeDecoration(
                                      color: const Color(0xFFFDE293),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(120),
                                      ),
                                    ),
                                    child: icon,
                                  ),
                                )
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Constants.largeVerticalGutter.verticalSpace,
              Text(
                'SPEAKER BIO',
                style: theme.textTheme?.body04,
              ),
              Constants.smallVerticalGutter.verticalSpace,
              Text(
                'Wake up to reality! Nothing ever goes as planned in this accursed world. The longer you live, the more you realize that the only things that truly exist in this reality are merely pain, suffering and futility. Listen, everywhere you look in this world, wherever there is light, there will always be shadows to be found as well. As long as there is a concept of victors, the vanquished will also exist. The selfish intent of wanting to preserve peace, initiates war and hatred is born in order to protect love. There are nexuses causal relationships that cannot be separated.',
                style: theme.textTheme?.body03?.copyWith(
                  color: isDark ? DevfestColors.grey80 : DevfestColors.grey10,
                ),
              ),
              Constants.verticalGutter.verticalSpace,
              Text(
                'TALK',
                style: DevFestTheme.of(context).textTheme?.body04,
              ),
              Constants.smallVerticalGutter.verticalSpace,
              const SpeakerActionCard(),
            ],
          ),
        ),
      ),
    );
  }
}

class SpeakerAvatar extends StatelessWidget {
  const SpeakerAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 133.w,
      height: 148.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: DevfestColors.yellowSecondary,
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.only(left: 1, right: 6, top: 1, bottom: 6).w,
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            bottomLeft: Radius.circular(15),
            topRight: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          image: DecorationImage(
            image: NetworkImage("https://via.placeholder.com/133x148"),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
