import 'package:devfest23/core/data/data.dart';
import 'package:devfest23/core/enums/tab_item.dart';
import 'package:devfest23/core/router/module_provider.dart';
import 'package:devfest23/core/router/navigator.dart';
import 'package:devfest23/core/size_util.dart';
import 'package:devfest23/core/themes/themes.dart';
import 'package:devfest23/core/utils.dart';
import 'package:devfest23/core/widgets/schedule_tab_bar.dart';
import 'package:devfest23/core/widgets/widgets.dart';
import 'package:devfest23/features/agenda/pages/agenda_base.dart';
import 'package:devfest23/features/home/pages/home.dart';
import 'package:devfest23/features/schedule/application/application.dart';
import 'package:devfest23/features/schedule/pages/schedule_base.dart';
import 'package:devfest23/features/speakers/application/application.dart';
import 'package:devfest23/features/speakers/page/speakers_base.dart';
import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:mocktail/mocktail.dart';

import '../../../commons.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setupFirebaseAuthMocks();

  final mockDevfestRepo = MockDevfestRepository();
  final mockFirebaseAuth = MockFirebaseAuth();
  final mockFirebaseNotificationManager = MockFirebaseNotificationManager();

  setUpAll(() async {
    when(() => mockDevfestRepo.fetchSessions()).thenAnswer(
      (_) {
        var session = Session.empty();
        session = session.copyWith(sessionDate: DateTime(2023, 11, 24));
        return Future.value(
          Right(
            SessionsResponseDto(
              sessions: [Session.empty()], // TODO: Add some fake sessions here
            ),
          ),
        );
      },
    );
    when(() => mockFirebaseNotificationManager.deviceToken).thenAnswer(
      (_) => Future.value('token'),
    );
    when(() => mockDevfestRepo.updateUserDeviceToken(
        const UpdateTokenRequestDto(deviceToken: 'token'))).thenAnswer(
      (_) => Future.value(
        const Right(true),
      ),
    );
    when(() => mockDevfestRepo.fetchSpeakers()).thenAnswer(
      (_) => Future.value(
        Right(
          SpeakersResponseDto(
            speakers: [Speaker.empty()], // TODO: Add some fake speakers here
          ),
        ),
      ),
    );
    when(() => mockDevfestRepo.fetchSessionCategories()).thenAnswer(
      (_) => Future.value(
        const Right(
          CategoriesResponseDto(
            categories: [Category(imageUrl: 'imageUrl', name: 'someCategory')],
          ),
        ),
      ),
    );
    when(() => mockDevfestRepo.fetchRSVPSessions()).thenAnswer(
      (_) => Future.value(
        const Right([]),
      ),
    );

    final app = await Firebase.initializeApp(
      name: 'testApp',
      options: const FirebaseOptions(
        apiKey: '',
        appId: '',
        messagingSenderId: '',
        projectId: '',
      ),
    );
    FirebaseAuth.instanceFor(app: app);
  });

  group('$AppHome $AgendaView works as expected', () {
    testWidgets('$AgendaView loads correctly', (WidgetTester tester) async {
      final _dateFormat = DateFormat('MMMM, yyyy');
      final _dayFormat = DateFormat('dd');
      final _day2 = DateTime(2023, 11, 25);

      // Mock the providers
      final container = ProviderContainer(
        overrides: [
          devfestRepositoryProvider.overrideWithValue(mockDevfestRepo),
          sessionsViewModelProvider.overrideWith(
            (ref) => SessionsViewModel(
              ref.read(devfestRepositoryProvider),
              mockFirebaseAuth,
              mockFirebaseNotificationManager,
            ),
          ),
          speakersViewModelProvider.overrideWith(
            (ref) => SpeakersViewModel(
              ref.read(devfestRepositoryProvider),
            ),
          ),
        ],
      );

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: ScreenUtilInit(
              designSize: designSize,
              minTextAdapt: true,
              builder: (_, __) {
                return MaterialApp(
                    theme: ThemeData.light().copyWith(
                      extensions: <ThemeExtension<dynamic>>[
                        DevFestTheme.light(),
                      ],
                    ),
                    navigatorKey: AppNavigator.getKey(Module.general),
                    home: const AppHome(tab: TabItem.home));
              }),
        ),
      );

      // Initial build
      await tester.pumpAndSettle();

      // Check if TabBarView is present
      expect(find.byType(TabBarView), findsOneWidget);

      // Check for the presence of FloatingActionButton
      expect(find.byType(FloatingActionButton), findsOneWidget);

      // Interact with FloatingActionButton
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle(); // Wait for any async operations to complete

      // Check for bottom navigation bar items
      expect(find.byType(DevfestBottomNav), findsOneWidget);

      // Verify the TabController index changes
      expect(pageController.index, 0); // 'Agenda' is at index 0

      // Find the ScheduleTabBar widget
      final scheduleTabBarFinder = find.byType(ScheduleTabBar);
      expect(scheduleTabBarFinder, findsOneWidget);

      // TODO: Find schedule tiles and tao one
      // Verify ScheduleTiles are rendered
      // expect(find.byType(ScheduleTile), findsNWidgets(1));
      // TODO: Tap card and navigate to seeion detaik

      // Simulate tapping on a tab in the ScheduleTabBar
      // Assuming the tabs are indexed and you want to tap on the second tab
      expect(find.byType(ScheduleTabBar), findsOneWidget);
      await tester.tap(find.descendant(
        of: scheduleTabBarFinder,
        matching: find.byType(InkWell).at(1),
      ));
      await tester.pumpAndSettle();

      expect(
          find.text(
              '${_dayFormat.format(_day2)}${nthNumber(_day2.day)} ${_dateFormat.format(_day2)}'),
          findsOneWidget);

      // Clean up
      container.dispose();
    });
  });

  group('$AppHome $ScheduleView works as expected', () {
    testWidgets('$ScheduleView widget test', (WidgetTester tester) async {
      // Mock the providers
      final container = ProviderContainer(
        overrides: [
          devfestRepositoryProvider.overrideWithValue(mockDevfestRepo),
          sessionsViewModelProvider.overrideWith(
            (ref) => SessionsViewModel(
              ref.read(devfestRepositoryProvider),
              mockFirebaseAuth,
              mockFirebaseNotificationManager,
            ),
          ),
          speakersViewModelProvider.overrideWith(
            (ref) => SpeakersViewModel(
              ref.read(devfestRepositoryProvider),
            ),
          ),
        ],
      );

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: ScreenUtilInit(
              designSize: designSize,
              minTextAdapt: true,
              builder: (_, __) {
                return MaterialApp(
                    theme: ThemeData.light().copyWith(
                      extensions: <ThemeExtension<dynamic>>[
                        DevFestTheme.light(),
                      ],
                    ),
                    navigatorKey: AppNavigator.getKey(Module.general),
                    home: const AppHome(tab: TabItem.home));
              }),
        ),
      );

      // Initial build
      await tester.pumpAndSettle();

      // Check if TabBarView is present
      expect(find.byType(TabBarView), findsOneWidget);

      // Check for the presence of FloatingActionButton
      expect(find.byType(FloatingActionButton), findsOneWidget);

      // Interact with FloatingActionButton
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle(); // Wait for any async operations to complete

      // Check for bottom navigation bar items
      expect(find.byType(DevfestBottomNav), findsOneWidget);

      // Interact with bottom navigation bar
      await tester.tap(find.text('Schedule'));
      await tester.pumpAndSettle(); // Wait for the page change animation

      // Verify the TabController index changes
      expect(pageController.index, 1); // 'Schedule' is at index 1

      expect(find.byType(ScheduleView), findsOneWidget);
    });
  });

  group('$AppHome $SpeakersView works as expected', () {
    testWidgets('$SpeakersView widget test', (WidgetTester tester) async {
      // Mock the providers
      final container = ProviderContainer(
        overrides: [
          devfestRepositoryProvider.overrideWithValue(mockDevfestRepo),
          sessionsViewModelProvider.overrideWith(
            (ref) => SessionsViewModel(
              ref.read(devfestRepositoryProvider),
              mockFirebaseAuth,
              mockFirebaseNotificationManager,
            ),
          ),
          speakersViewModelProvider.overrideWith(
            (ref) => SpeakersViewModel(
              ref.read(devfestRepositoryProvider),
            ),
          ),
        ],
      );

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: ScreenUtilInit(
              designSize: designSize,
              minTextAdapt: true,
              builder: (_, __) {
                return MaterialApp(
                    theme: ThemeData.light().copyWith(
                      extensions: <ThemeExtension<dynamic>>[
                        DevFestTheme.light(),
                      ],
                    ),
                    navigatorKey: AppNavigator.getKey(Module.general),
                    home: const AppHome(tab: TabItem.home));
              }),
        ),
      );

      // Initial build
      await tester.pumpAndSettle();

      // Check if TabBarView is present
      expect(find.byType(TabBarView), findsOneWidget);

      // Check for the presence of FloatingActionButton
      expect(find.byType(FloatingActionButton), findsOneWidget);

      // Interact with FloatingActionButton
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle(); // Wait for any async operations to complete

      // Check for bottom navigation bar items
      expect(find.byType(DevfestBottomNav), findsOneWidget);

      // Interact with bottom navigation bar
      await tester.tap(find.text('Speakers'));
      await tester.pumpAndSettle(); // Wait for the page change animation

      // Verify the TabController index changes
      expect(pageController.index, 2); // 'Speakers' is at index 2

      expect(find.byType(SpeakersView), findsOneWidget);

      // Clean up
      container.dispose();
    });
  });
}
