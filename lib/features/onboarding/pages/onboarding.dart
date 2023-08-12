import 'package:devfest23/core/themes/colors.dart';
import 'package:devfest23/core/themes/theme_data.dart';
import 'package:devfest23/core/widgets/buttons.dart';
import 'package:devfest23/features/onboarding/widgets/title_tile.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants.dart';
import '../../../core/router/routes.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DevFestTheme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: DevFestTheme.of(context).backgroundColor,
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Constants.horizontalMargin),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleTile(
                    emoji: '🤭',
                    title: 'Welcome Back!',
                    backgroundColor: const Color(0xff81c995).withOpacity(0.2),
                  ),
                  Text(
                    'We are back and ready to awe',
                    style: DevFestTheme.of(context)
                        .textTheme
                        ?.headline02
                        ?.copyWith(
                          color: DevFestTheme.of(context).onBackgroundColor,
                          height: 1.2,
                        ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 50),
                    child: Text(
                      'We have great speakers and amazing sessions in place for this year’s DevFest! 🥳',
                      style: DevFestTheme.of(context)
                          .textTheme
                          ?.body02
                          ?.copyWith(
                              color: MediaQuery.platformBrightnessOf(context) ==
                                      Brightness.dark
                                  ? DevfestColors.grey70
                                  : DevfestColors.grey30),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            const Categories(),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Constants.horizontalMargin),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DevfestFilledButton(
                    title: const Text('Login to RSVP'),
                    onPressed: () {
                      context.go('${RoutePaths.onboarding}/${RoutePaths.auth}');
                    },
                  ),
                  const SizedBox(height: 13),
                  DevfestOutlinedButton(
                    title: const Text('Continue Without Login'),
                    onPressed: () {},
                  ),
                ],
              )🛠️🛠️
            ),
            const SizedBox(height: 26),
          ],
        ),
      ),
    );
  }
}

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          controller: ScrollController(initialScrollOffset: 20),
          child: const Row(
            children: [
              CategoryChip(
                chipColor: Color(0xffeee4dd),
                emoji: '🎨',
                title: 'Design',
              ),
              SizedBox(width: 8),
              CategoryChip(
                chipColor: Color(0xffffd4cc),
                emoji: '📊',
                title: 'Blockchain',
              ),
              SizedBox(width: 8),
              CategoryChip(
                chipColor: Color(0xffffd4cc),
                emoji: '🖼️',
                title: 'Frontend',
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          controller: ScrollController(initialScrollOffset: 50),
          child: const Row(
            children: [
              CategoryChip(
                chipColor: Color(0xffeeebdd),
                emoji: '🪛',
                title: 'Backend',
              ),
              SizedBox(width: 8),
              CategoryChip(
                chipColor: Color(0xffccf4ff),
                emoji: '☯️',
                title: 'Mental Health',
              ),
              SizedBox(width: 8),
              CategoryChip(
                chipColor: Color(0xffffe2cc),
                emoji: '⭐',
                title: 'Leader',
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          controller: ScrollController(initialScrollOffset: 40),
          child: const Row(
            children: [
              CategoryChip(
                chipColor: Color(0xffe6ddee),
                emoji: '💼',
                title: 'Product Management',
              ),
              SizedBox(width: 8),
              CategoryChip(
                chipColor: Color(0xffffebcc),
                emoji: '🛡️',
                title: 'Cybersecurity',
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          controller: ScrollController(initialScrollOffset: 35),
          child: const Row(
            children: [
              CategoryChip(
                chipColor: Color(0xfffdccff),
                emoji: '♠️',
                title: 'Networking',
              ),
              SizedBox(width: 8),
              CategoryChip(
                chipColor: Color(0xffccf8ff),
                emoji: '✨',
                title: 'DevOps',
              ),
              SizedBox(width: 8),
              CategoryChip(
                chipColor: Color(0xffefefdc),
                emoji: '📉',
                title: 'Big Data',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CategoryChip extends StatelessWidget {
  const CategoryChip({
    super.key,
    required this.chipColor,
    required this.emoji,
    required this.title,
  });

  final Color chipColor;
  final String emoji;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: chipColor,
        borderRadius: const BorderRadius.all(Radius.circular(48)),
      ),
      child: RichText(
        text: TextSpan(
            text: emoji,
            style: DevFestTheme.of(context)
                .textTheme
                ?.body01
                ?.copyWith(color: DevfestColors.grey20),
            children: [
              const WidgetSpan(child: SizedBox(width: 8)),
              TextSpan(text: title),
            ]),
      ),
    );
  }
}
