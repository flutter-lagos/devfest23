import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/providers/providers.dart';
import 'core/router/router.dart';
import 'core/themes/themes.dart';

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

    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) {
      ref.read(themeManagerProvider.notifier).getThemeMode(context);
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: appRouter.mainRouter.routerDelegate,
      routeInformationParser: appRouter.mainRouter.routeInformationParser,
      routeInformationProvider: appRouter.mainRouter.routeInformationProvider,
      debugShowCheckedModeBanner: false,
      themeMode: ref.watch(themeManagerProvider),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textTheme: TextTheme(
            bodyMedium: TextStyle(color: ref.watch(textColorProvider))),
        extensions: const <ThemeExtension<dynamic>>[
          /// Use the below format for raw theme data
          /// DevFestTheme(textTheme: DevfestTextTheme()),
          DevFestTheme.light(),
        ],
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textTheme: TextTheme(
            bodyMedium: TextStyle(color: ref.watch(textColorProvider))),
        extensions: const <ThemeExtension<dynamic>>[
          /// Use the below format for raw theme data
          /// DevFestTheme(textTheme: DevfestTextTheme()),
          DevFestTheme.dark(),
        ],
      ),
    );
  }
}
