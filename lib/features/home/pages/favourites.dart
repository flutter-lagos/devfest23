import 'package:devfest23/core/constants.dart';
import 'package:devfest23/core/icons.dart';
import 'package:devfest23/core/themes/colors.dart';
import 'package:devfest23/core/themes/theme_data.dart';
import 'package:devfest23/features/home/widgets/favourite_session_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FavouritesPage extends StatelessWidget {
  const FavouritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DevFestTheme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: DevFestTheme.of(context).backgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        leadingWidth: 100,
        leading: Row(
          children: [
            const SizedBox(width: Constants.horizontalMargin),
            SvgPicture.asset(
              AppIcons.devfestLogo,
              height: 16,
              fit: BoxFit.contain,
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            color: DevFestTheme.of(context).onBackgroundColor,
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: Constants.horizontalMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: Constants.verticalGutter),
            RichText(
              text: TextSpan(
                  text: 'Favourites',
                  style: DevFestTheme.of(context).textTheme?.title01?.copyWith(
                        color: DevFestTheme.of(context).onBackgroundColor,
                      ),
                  children: const [
                    WidgetSpan(child: SizedBox(width: 4)),
                    TextSpan(text: '❤️')
                  ]),
            ),
            const SizedBox(height: Constants.smallVerticalGutter),
            Text(
              'View all your saved sessions here',
              style: DevFestTheme.of(context).textTheme?.body02?.copyWith(
                    color: MediaQuery.platformBrightnessOf(context) ==
                            Brightness.dark
                        ? DevfestColors.grey80
                        : DevfestColors.grey40,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
