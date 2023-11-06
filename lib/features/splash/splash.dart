import 'package:firebase_auth/firebase_auth.dart';

import '../../core/enums/tab_item.dart';
import '../../core/images.dart';
import '../../core/router/navigator.dart';
import '../../core/router/routes.dart';
import '../../core/themes/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers/providers.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  late AssetImage image;

  @override
  void initState() {
    super.initState();

    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) async {
      Future.delayed(const Duration(seconds: 2), () {
        if (FirebaseAuth.instance.currentUser != null) {
          context.pushNamedAndClear('/app/${TabItem.home.name}');
          return;
        }
        context.goReplace(RoutePaths.onboarding);
      });
    });
  }

  @override
  void didChangeDependencies() {
    final isDark = ref.read(isDarkProvider);
    image = AssetImage(isDark ? AppImages.splashDark : AppImages.splashLight);
    precacheImage(image, context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DevFestTheme.of(context).backgroundColor,
      extendBody: true,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: DevFestTheme.of(context).backgroundColor,
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(image: image, fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}
