import 'package:devfest23/core/themes/theme_data.dart';
import 'package:flutter/material.dart';

class OnScreenLoader extends StatelessWidget {
  const OnScreenLoader({
    super.key,
    this.isLoading = false,
    required this.child,
  });

  final bool isLoading;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: isLoading,
      child: Stack(
        fit: StackFit.expand,
        children: [
          child,
          if (isLoading)
            Container(
              color:
                  DevFestTheme.of(context).onBackgroundColor?.withOpacity(0.4),
              child: Center(
                child: CircularProgressIndicator(
                  color: DevFestTheme.of(context).backgroundColor,
                  strokeCap: StrokeCap.round,
                  strokeWidth: 6,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
