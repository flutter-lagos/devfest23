import 'package:flutter/material.dart';

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

class DevfestApp extends StatefulWidget {
  const DevfestApp({super.key});

  @override
  State<DevfestApp> createState() => _DevfestAppState();
}

class _DevfestAppState extends State<DevfestApp> {
  late ThemeManager themeManager;

  @override
  void initState() {
    super.initState();
    themeManager = ThemeManager()
      ..addListener(() {
        setState(() {});
      });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: themeManager.themeMode,
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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  late ThemeManager themeManager;

  @override
  void initState() {
    super.initState();
    themeManager = ThemeManager()
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () => themeManager.toggleThemeMode(),
            icon: const Icon(Icons.lightbulb_outlined),
          )
        ],
      ),
      backgroundColor: DevFestTheme.of(context).backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
