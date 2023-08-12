import 'package:devfest23/core/images.dart';
import 'package:devfest23/core/router/routes.dart';
import 'package:devfest23/core/themes/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late AssetImage image;

  @override
  void initState() {
    super.initState();

    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 2), () {
        GoRouter.of(context).push(RoutePaths.onboarding);
      });
    });
  }

  @override
  void didChangeDependencies() {
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
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
