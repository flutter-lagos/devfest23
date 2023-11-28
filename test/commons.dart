import 'package:devfest23/core/data/data.dart';
import 'package:devfest23/core/router/module_provider.dart';
import 'package:devfest23/core/router/navigator.dart';
import 'package:devfest23/core/services/firebase_notification_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';

class RiverpodListener<T> extends Mock {
  void call(T? previous, T next);
}

class MockDevfestRepository extends Mock implements DevfestRepository {}

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockFirebaseUser extends Mock implements User {}

class MockFirebaseNotificationManager extends Mock
    implements FirebaseNotificationManager {}

class UnitTestApp extends StatelessWidget {
  const UnitTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: AppNavigator.getKey(Module.general),
      home: const ProviderScope(child: Scaffold()),
    );
  }
}
