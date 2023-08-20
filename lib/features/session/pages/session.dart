import 'package:flutter/material.dart';

import '../../../core/themes/themes.dart';
import '../../../core/widgets/widgets.dart';

class SessionPage extends StatefulWidget {
  const SessionPage({super.key});

  @override
  State<SessionPage> createState() => _SessionPageState();
}

class _SessionPageState extends State<SessionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DevFestTheme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: DevFestTheme.of(context).backgroundColor,
        elevation: 0,
        leadingWidth: 120,
        leading: const GoBackButton(),
      ),
    );
  }
}
