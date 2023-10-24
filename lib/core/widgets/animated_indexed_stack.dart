import 'package:flutter/material.dart';

class AnimatedIndexedStack extends StatelessWidget {
  const AnimatedIndexedStack(
      {super.key,
      required this.index,
      required this.children,
      this.duration = const Duration(milliseconds: 250)});
  final int index;
  final List<Widget> children;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: index,
      sizing: StackFit.expand,
      children: [
        for (var i = 0; i < children.length; i++)
          AnimatedScale(
            key: children[i].key,
            scale: index == i ? 1.0 : 0.98,
            curve: Curves.easeIn,
            duration: duration,
            child: AnimatedOpacity(
              opacity: index == i ? 1.0 : 0.0,
              duration: duration,
              curve: Curves.decelerate,
              child: children[i],
            ),
          ),
      ],
    );
  }
}
