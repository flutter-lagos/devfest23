import 'package:devfest23/core/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../constants.dart';
import 'widgets.dart';

@widgetbook.UseCase(name: 'Filled Button', type: DevfestButtons)
Widget devfestFilledButton(BuildContext context) {
  return Material(
    color: DevFestTheme.of(context).backgroundColor,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DevfestFilledButton(
          prefixIcon: const Icon(Icons.arrow_back),
          title: const Text('Content'),
          onPressed: () {},
        ),
        const SizedBox(height: 10),
        DevfestFilledButton(
          title: const Text('Content'),
          suffixIcon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        const SizedBox(height: 10),
        DevfestFilledButton(
          prefixIcon: const Icon(Icons.arrow_back),
          suffixIcon: const Icon(Icons.arrow_back),
          title: const Text('Content'),
          onPressed: () {},
        ),
        const SizedBox(height: 10),
        DevfestFilledButton(
          title: const Text('Content'),
          onPressed: () {},
        ),
        const SizedBox(height: 10),
        DevfestFilledButton(
          suffixIcon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(name: 'Outlined Button', type: DevfestButtons)
Widget devfestOutlinedButton(BuildContext context) {
  return Material(
    color: DevFestTheme.of(context).backgroundColor,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DevfestOutlinedButton(
          prefixIcon: const Icon(Icons.arrow_back),
          title: const Text('Content'),
          onPressed: () {},
        ),
        const SizedBox(height: 10),
        DevfestOutlinedButton(
          suffixIcon: const Icon(Icons.arrow_back),
          title: const Text('Content'),
          onPressed: () {},
        ),
        const SizedBox(height: 10),
        DevfestOutlinedButton(
          prefixIcon: const Icon(Icons.arrow_back),
          suffixIcon: const Icon(Icons.arrow_back),
          title: const Text('Content'),
          onPressed: () {},
        ),
        const SizedBox(height: 10),
        DevfestOutlinedButton(
          prefixIcon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        const SizedBox(height: 10),
        DevfestOutlinedButton(
          title: const Text('Content'),
          onPressed: () {},
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(name: 'Favourite Button', type: DevfestButtons)
Widget devfestFavouriteButton(BuildContext context) {
  bool isFavourite0 = true;
  bool isFavourite1 = false;
  return StatefulBuilder(builder: (context, setState) {
    return Material(
      color: DevFestTheme.of(context).backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DevfestFavouriteButton(
              isFavourite: isFavourite0,
              onPressed: () {
                setState(() => isFavourite0 = !isFavourite0);
              },
            ),
            const SizedBox(height: 10),
            DevfestFavouriteButton(
              isFavourite: isFavourite1,
              onPressed: () {
                setState(() => isFavourite1 = !isFavourite1);
              },
            ),
          ],
        ),
      ),
    );
  });
}

class DevfestFilledButton extends StatelessWidget {
  const DevfestFilledButton({
    super.key,
    this.title,
    this.prefixIcon,
    this.suffixIcon,
    this.onPressed,
  });

  final Widget? title;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final VoidCallback? onPressed;

  static const _space = SizedBox(width: 8);

  @override
  Widget build(BuildContext context) {
    final buttonTheme = DevFestTheme.of(context).buttonTheme ??
        const DevfestButtonTheme.light();
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: onPressed,
        customBorder: buttonTheme.shape,
        child: AnimatedDefaultTextStyle(
          duration: Constants.kAnimationDur,
          style: buttonTheme.textStyle,
          child: IconTheme(
            data: IconThemeData(color: buttonTheme.iconColor),
            child: AnimatedContainer(
              duration: Constants.kAnimationDur,
              height: 67,
              width: double.infinity,
              decoration: ShapeDecoration(
                shape: buttonTheme.shape,
                color: buttonTheme.backgroundColor,
              ),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: switch ((prefixIcon, title, suffixIcon)) {
                  (final prefix?, null, null) => [prefix],
                  (null, final title?, null) => [title],
                  (null, null, final suffix?) => [suffix],
                  (final prefix?, final title?, null) => [
                      prefix,
                      _space,
                      title
                    ],
                  (final prefix?, null, final suffix?) => [
                      prefix,
                      _space,
                      suffix
                    ],
                  (null, final title?, final suffix?) => [
                      title,
                      _space,
                      suffix
                    ],
                  (final prefix?, final title?, final suffix?) => [
                      prefix,
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: _space.width!),
                        child: title,
                      ),
                      suffix
                    ],
                  _ => [],
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DevfestOutlinedButton extends StatelessWidget {
  const DevfestOutlinedButton({
    super.key,
    this.title,
    this.prefixIcon,
    this.suffixIcon,
    this.onPressed,
  });

  final Widget? title;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final VoidCallback? onPressed;

  static const _space = SizedBox(width: 8);

  @override
  Widget build(BuildContext context) {
    final outlinedButtonTheme = DevFestTheme.of(context).outlinedButtonTheme ??
        const DevfestOutlinedButtonTheme.light();
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: onPressed,
        customBorder: outlinedButtonTheme.shape,
        child: AnimatedDefaultTextStyle(
          duration: Constants.kAnimationDur,
          style: outlinedButtonTheme.textStyle,
          child: IconTheme(
            data: IconThemeData(color: outlinedButtonTheme.iconColor),
            child: AnimatedContainer(
              duration: Constants.kAnimationDur,
              height: 67,
              width: double.infinity,
              decoration: ShapeDecoration(
                shape: outlinedButtonTheme.shape.copyWith(
                    side: BorderSide(color: outlinedButtonTheme.outlineColor)),
                color: Colors.transparent,
              ),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: switch ((prefixIcon, title, suffixIcon)) {
                  (final prefix?, null, null) => [prefix],
                  (null, final title?, null) => [title],
                  (null, null, final suffix?) => [suffix],
                  (final prefix?, final title?, null) => [
                      prefix,
                      _space,
                      title
                    ],
                  (final prefix?, null, final suffix?) => [
                      prefix,
                      _space,
                      suffix
                    ],
                  (null, final title?, final suffix?) => [
                      title,
                      _space,
                      suffix
                    ],
                  (final prefix?, final title?, final suffix?) => [
                      prefix,
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: _space.width!),
                        child: title,
                      ),
                      suffix
                    ],
                  _ => [],
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DevfestFavouriteButton extends StatelessWidget {
  const DevfestFavouriteButton({
    super.key,
    this.title,
    this.prefixIcon,
    this.suffixIcon,
    this.onPressed,
    this.isFavourite = false,
  });

  final Widget? title;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final VoidCallback? onPressed;
  final bool isFavourite;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Constants.kAnimationDur,
      child: () {
        if (isFavourite) {
          return DevfestOutlinedButton(
            title: title ?? const Text('Remove from Favourites'),
            prefixIcon: prefixIcon ??
                const Icon(
                  Symbols.grade_rounded,
                  weight: Constants.iconWeight,
                  color: DevfestColors.yellow,
                  fill: 1,
                ),
            suffixIcon: suffixIcon,
            onPressed: onPressed,
          );
        }

        return DevfestFilledButton(
          title: title ?? const Text('Add to Favourites'),
          prefixIcon: prefixIcon ??
              const Icon(Symbols.grade, weight: Constants.iconWeight),
          suffixIcon: suffixIcon,
          onPressed: onPressed,
        );
      }(),
    );
  }
}
