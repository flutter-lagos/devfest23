import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/router/router.dart';
import 'core/themes/themes.dart';

class ThemeManager extends ChangeNotifier {
  // Private constructor
  ThemeManager._privateConstructor();

  // Static instance variable
  static final ThemeManager _instance = ThemeManager._privateConstructor();

  // Factory method to return the same instance
  factory ThemeManager() {
    return _instance;
  }

  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  void toggleThemeMode() {
    _themeMode =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class DevfestApp extends ConsumerStatefulWidget {
  const DevfestApp({super.key});

  @override
  ConsumerState<DevfestApp> createState() => _DevfestAppState();
}

class _DevfestAppState extends ConsumerState<DevfestApp> {
  late AppRouter appRouter;

  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
    appRouter = AppRouter(ref);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: appRouter.mainRouter.routerDelegate,
      routeInformationParser: appRouter.mainRouter.routeInformationParser,
      routeInformationProvider: appRouter.mainRouter.routeInformationProvider,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      // builder: (context, child) {
      //   return DefaultTextStyle(
      //     style: TextStyle(
      //       color: MediaQuery.platformBrightnessOf(context) == Brightness.dark
      //           ? DevfestColors.green
      //           : DevfestColors.grey0,
      //     ),
      //     child: child!,
      //   );
      // },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        extensions: const <ThemeExtension<dynamic>>[
          /// Use the below format for raw theme data
          /// DevFestTheme(textTheme: DevfestTextTheme()),
          DevFestTheme.light(),
        ],
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        extensions: const <ThemeExtension<dynamic>>[
          /// Use the below format for raw theme data
          /// DevFestTheme(textTheme: DevfestTextTheme()),
          DevFestTheme.dark(),
        ],
      ),
    );
  }
}
