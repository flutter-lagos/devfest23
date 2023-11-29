import 'package:devfest23/core/data/data.dart';
import 'package:devfest23/core/router/module_provider.dart';
import 'package:devfest23/core/router/navigator.dart';
import 'package:devfest23/core/services/firebase_notification_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class RiverpodListener<T> extends Mock {
  void call(T? previous, T next);
}

class MockDevfestRepository extends Mock implements DevfestRepository {}

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class TestFirebaseAuthPlatform extends FirebaseAuthPlatform {
  TestFirebaseAuthPlatform() : super();

  void instanceFor({
    FirebaseApp? app,
    Map<dynamic, dynamic>? pluginConstants,
  }) {}

  @override
  FirebaseAuthPlatform delegateFor(
      {FirebaseApp? app, Persistence? persistence}) {
    return this;
  }

  @override
  FirebaseAuthPlatform setInitialValues({
    PigeonUserDetails? currentUser,
    String? languageCode,
  }) {
    return this;
  }
}

class MockFurebaseAuthPlatform extends Mock
    with MockPlatformInterfaceMixin
    implements TestFirebaseAuthPlatform {}

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

typedef Callback = void Function(MethodCall call);

void setupFirebaseAuthMocks([Callback? customHandlers]) {
  TestWidgetsFlutterBinding.ensureInitialized();

  setupFirebaseCoreMocks();
}

Future<T> neverEndingFuture<T>() async {
  while (true) {
    await Future.delayed(const Duration(minutes: 5));
  }
}
