import 'package:devfest23/core/router/module_provider.dart';
import 'package:devfest23/core/router/router.dart';
import 'package:devfest23/core/size_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/providers/providers.dart';
import 'core/router/navigator.dart';
import 'core/themes/themes.dart';

class DevfestApp extends ConsumerStatefulWidget {
  const DevfestApp({super.key});

  @override
  ConsumerState<DevfestApp> createState() => _DevfestAppState();
}

class _DevfestAppState extends ConsumerState<DevfestApp> {
  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();

    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) {
      ref.read(themeManagerProvider.notifier).getThemeMode(context);
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: designSize,
      minTextAdapt: true,
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: ref.watch(themeManagerProvider),
          navigatorKey: AppNavigator.getKey(Module.general),
          onGenerateRoute: AppRouter.generateRoutes,
          onUnknownRoute: (settings) => MaterialPageRoute(
            settings: settings,
            builder: (_) => Scaffold(
              body: Center(
                child: Text('No route defined for ${settings.name}'),
              ),
            ),
          ),
          routes: AppRouter.routes,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
            textTheme: TextTheme(
              bodyMedium: TextStyle(
                fontFamily: 'Google Sans',
                color: ref.watch(textColorProvider),
              ),
            ),
            extensions: <ThemeExtension<dynamic>>[
              /// Use the below format for raw theme data
              /// DevFestTheme(textTheme: DevfestTextTheme()),
              DevFestTheme.light(),
            ],
          ),
          darkTheme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
            textTheme: TextTheme(
              bodyMedium: TextStyle(
                fontFamily: 'Google Sans',
                color: ref.watch(textColorProvider),
              ),
            ),
            extensions: <ThemeExtension<dynamic>>[
              /// Use the below format for raw theme data
              /// DevFestTheme(textTheme: DevfestTextTheme()),
              DevFestTheme.dark(),
            ],
          ),
        );
      },
    );
  }
}
