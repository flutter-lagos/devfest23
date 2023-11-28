import 'package:devfest23/core/constants.dart';
import 'package:devfest23/core/data/data.dart';
import 'package:devfest23/core/exceptions/exceptions.dart';
import 'package:devfest23/core/ui_state_model/ui_state_model.dart';
import 'package:devfest23/features/schedule/application/application.dart';
import 'package:devfest23/features/schedule/application/sessions/ui_state.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../commons.dart';

void main() {
  final mockDevfestRepo = MockDevfestRepository();
  final mockFirebaseAuth = MockFirebaseAuth();
  final mockFirebaseNotificationManager = MockFirebaseNotificationManager();

  group('Sessions view model testing suite', () {
    late ProviderContainer container;
    late RiverpodListener<SessionsUiState> listener;

    setUpAll(() => registerFallbackValue(const SessionsUiState.initial()));

    setUp(() {
      container = ProviderContainer(overrides: [
        devfestRepositoryProvider.overrideWithValue(mockDevfestRepo),
        sessionsViewModelProvider.overrideWith(
          (ref) => SessionsViewModel(ref.read(devfestRepositoryProvider),
              mockFirebaseAuth, mockFirebaseNotificationManager),
        )
      ]);
      listener = RiverpodListener();
    });

    tearDown(() => container.dispose());

    test('Fetch sessions when current user is null success test', () async {
      when(() => mockDevfestRepo.fetchSessions())
          .thenAnswer((_) => Future.value(Right(SessionsResponseDto(
                sessions: [
                  Session(
                    sessionId: '1',
                    title: 'title',
                    description: 'description',
                    availableSeats: 10,
                    hasRsvped: false,
                    owner: '',
                    level: '',
                    scheduledDuration: '',
                    hall: '',
                    category: '',
                    scheduledAt: '',
                    sessionFormat: '',
                    ownerEmail: '',
                    speakerImage: '',
                    tagLine: '',
                    slot: 100,
                    sessionDate: Constants.day1,
                    order: 0,
                  )
                ],
              ))));

      when(() => mockFirebaseAuth.currentUser).thenReturn(null);

      expect(
          container.read(sessionsViewModelProvider).viewState, ViewState.idle);

      container.listen(sessionsViewModelProvider, listener.call,
          fireImmediately: true);
      final currState = container.read(sessionsViewModelProvider);

      await container.read(sessionsViewModelProvider.notifier).fetchSessions();

      verifyInOrder([
        () => listener(null, currState.copyWith(viewState: ViewState.idle)),
        () => listener(
            any(that: isA<SessionsUiState>()),
            any(
                that: isA<SessionsUiState>().having(
                    (s) => s.viewState, 'viewState', ViewState.loading))),
        () => listener(
              any(that: isA<SessionsUiState>()),
              any(
                  that: isA<SessionsUiState>()
                      .having(
                          (s) => s.viewState, 'viewState', ViewState.success)
                      .having((s) => s.sessions.isEmpty,
                          'Session list is not empty', false)),
            ),
      ]);
    });

    testWidgets('Fetch sessions when user is null failure test',
        (widgetTester) async {
      when(() => mockDevfestRepo.fetchSessions()).thenAnswer((_) =>
          Future.value(
              const Left(ClientException(exceptionMessage: 'Fetch failed'))));
      when(() => mockFirebaseAuth.currentUser).thenReturn(null);

      expect(
          container.read(sessionsViewModelProvider).viewState, ViewState.idle);

      container.listen(sessionsViewModelProvider, listener.call,
          fireImmediately: true);
      final currState = container.read(sessionsViewModelProvider);

      await widgetTester.pumpWidget(const UnitTestApp());
      await container.read(sessionsViewModelProvider.notifier).fetchSessions();
      await widgetTester.pumpAndSettle();

      verifyInOrder([
        () => listener(null, currState.copyWith(viewState: ViewState.idle)),
        () => listener(
            any(that: isA<SessionsUiState>()),
            any(
                that: isA<SessionsUiState>().having(
                    (s) => s.viewState, 'viewState', ViewState.loading))),
        () => listener(
            any(that: isA<SessionsUiState>()),
            any(
                that: isA<SessionsUiState>()
                    .having((s) => s.viewState, 'viewState', ViewState.error)
                    .having((s) => s.exception, 'exception',
                        const ClientException(exceptionMessage: 'Fetch failed'))
                    .having((s) => s.sessions.isEmpty, 'Session list is  empty',
                        true))),
      ]);
    });

    test('Fetch sessions when user is not null success test', () async {
      when(() => mockDevfestRepo.fetchSessions())
          .thenAnswer((_) => Future.value(Right(SessionsResponseDto(
                sessions: [
                  Session(
                    sessionId: '1',
                    title: 'title',
                    description: 'description',
                    availableSeats: 10,
                    hasRsvped: false,
                    owner: '',
                    level: '',
                    scheduledDuration: '',
                    hall: '',
                    category: '',
                    scheduledAt: '',
                    sessionFormat: '',
                    ownerEmail: '',
                    speakerImage: '',
                    tagLine: '',
                    slot: 100,
                    sessionDate: Constants.day1,
                    order: 0,
                  )
                ],
              ))));

      when(() => mockDevfestRepo.fetchRSVPSessions())
          .thenAnswer((_) => Future.value(const Right(['1'])));

      when(() => mockDevfestRepo.updateUserDeviceToken(
              const UpdateTokenRequestDto(deviceToken: 'testToken')))
          .thenAnswer((_) => Future.value(const Right(null)));

      when(() => mockFirebaseAuth.currentUser).thenReturn(MockFirebaseUser());

      when(() => mockFirebaseNotificationManager.deviceToken)
          .thenAnswer((_) => Future.value('testToken'));

      expect(
          container.read(sessionsViewModelProvider).viewState, ViewState.idle);

      container.listen(sessionsViewModelProvider, listener.call,
          fireImmediately: true);
      final currState = container.read(sessionsViewModelProvider);

      await container.read(sessionsViewModelProvider.notifier).fetchSessions();

      verifyInOrder([
        () => listener(null, currState.copyWith(viewState: ViewState.idle)),
        () => listener(
            any(that: isA<SessionsUiState>()),
            any(
                that: isA<SessionsUiState>().having(
                    (s) => s.viewState, 'viewState', ViewState.loading))),
        () => listener(
              any(that: isA<SessionsUiState>()),
              any(
                  that: isA<SessionsUiState>()
                      .having(
                          (s) => s.viewState, 'viewState', ViewState.success)
                      .having((s) => s.sessions.isEmpty,
                          'Session list is not empty', false)),
            ),
      ]);
    });

    testWidgets('Fetch sessions when user is not null failure test',
        (widgetTester) async {
      when(() => mockDevfestRepo.fetchSessions()).thenAnswer((_) =>
          Future.value(
              const Left(ClientException(exceptionMessage: 'Fetch failed'))));
      when(() => mockDevfestRepo.fetchRSVPSessions())
          .thenAnswer((_) => Future.value(const Right(['1'])));
      when(() => mockDevfestRepo.updateUserDeviceToken(
              const UpdateTokenRequestDto(deviceToken: 'testToken')))
          .thenAnswer((_) => Future.value(const Right(null)));
      when(() => mockFirebaseAuth.currentUser).thenReturn(MockFirebaseUser());
      when(() => mockFirebaseNotificationManager.deviceToken)
          .thenAnswer((_) => Future.value('testToken'));

      expect(
          container.read(sessionsViewModelProvider).viewState, ViewState.idle);

      container.listen(sessionsViewModelProvider, listener.call,
          fireImmediately: true);
      final currState = container.read(sessionsViewModelProvider);

      await widgetTester.pumpWidget(const UnitTestApp());
      await container.read(sessionsViewModelProvider.notifier).fetchSessions();
      await widgetTester.pumpAndSettle();

      verifyInOrder([
        () => listener(null, currState.copyWith(viewState: ViewState.idle)),
        () => listener(
            any(that: isA<SessionsUiState>()),
            any(
                that: isA<SessionsUiState>().having(
                    (s) => s.viewState, 'viewState', ViewState.loading))),
        () => listener(
            any(that: isA<SessionsUiState>()),
            any(
                that: isA<SessionsUiState>()
                    .having((s) => s.viewState, 'viewState', ViewState.error)
                    .having((s) => s.exception, 'exception',
                        const ClientException(exceptionMessage: 'Fetch failed'))
                    .having((s) => s.sessions.isEmpty, 'Session list is  empty',
                        true))),
      ]);
    });

    testWidgets('Fetch rsvp sessions failure test', (widgetTester) async {
      when(() => mockDevfestRepo.fetchSessions())
          .thenAnswer((_) => Future.value(Right(SessionsResponseDto(
                sessions: [
                  Session(
                    sessionId: '1',
                    title: 'title',
                    description: 'description',
                    availableSeats: 10,
                    hasRsvped: false,
                    owner: '',
                    level: '',
                    scheduledDuration: '',
                    hall: '',
                    category: '',
                    scheduledAt: '',
                    sessionFormat: '',
                    ownerEmail: '',
                    speakerImage: '',
                    tagLine: '',
                    slot: 100,
                    sessionDate: Constants.day1,
                    order: 0,
                  )
                ],
              ))));

      when(() => mockDevfestRepo.fetchRSVPSessions()).thenAnswer((_) =>
          Future.value(
              const Left(ClientException(exceptionMessage: 'Fetch failed'))));

      when(() => mockFirebaseAuth.currentUser).thenReturn(MockFirebaseUser());

      when(() => mockFirebaseNotificationManager.deviceToken)
          .thenAnswer((_) => Future.value('testToken'));

      expect(
          container.read(sessionsViewModelProvider).viewState, ViewState.idle);

      container.listen(sessionsViewModelProvider, listener.call,
          fireImmediately: true);
      final currState = container.read(sessionsViewModelProvider);

      await widgetTester.pumpWidget(const UnitTestApp());
      await container.read(sessionsViewModelProvider.notifier).fetchSessions();
      await widgetTester.pumpAndSettle();

      verifyInOrder([
        () => listener(null, currState.copyWith(viewState: ViewState.idle)),
        () => listener(
            any(that: isA<SessionsUiState>()),
            any(
                that: isA<SessionsUiState>().having(
                    (s) => s.viewState, 'viewState', ViewState.loading))),
        () => listener(
            any(that: isA<SessionsUiState>()),
            any(
                that: isA<SessionsUiState>()
                    .having((s) => s.viewState, 'viewState', ViewState.error)
                    .having((s) => s.exception, 'exception',
                        const ClientException(exceptionMessage: 'Fetch failed'))
                    .having((s) => s.sessions.isEmpty, 'Session list is  empty',
                        true))),
      ]);
    });

    test('Update device token failure test', () async {
      when(() => mockDevfestRepo.fetchSessions())
          .thenAnswer((_) => Future.value(Right(SessionsResponseDto(
                sessions: [
                  Session(
                    sessionId: '1',
                    title: 'title',
                    description: 'description',
                    availableSeats: 10,
                    hasRsvped: false,
                    owner: '',
                    level: '',
                    scheduledDuration: '',
                    hall: '',
                    category: '',
                    scheduledAt: '',
                    sessionFormat: '',
                    ownerEmail: '',
                    speakerImage: '',
                    tagLine: '',
                    slot: 100,
                    sessionDate: Constants.day1,
                    order: 0,
                  )
                ],
              ))));

      when(() => mockDevfestRepo.fetchRSVPSessions())
          .thenAnswer((_) => Future.value(const Right(['1'])));

      when(() => mockDevfestRepo.updateUserDeviceToken(
              const UpdateTokenRequestDto(deviceToken: 'testToken')))
          .thenAnswer((_) => Future.value(
              const Left(ClientException(exceptionMessage: 'Fetch failed'))));

      when(() => mockFirebaseAuth.currentUser).thenReturn(MockFirebaseUser());

      when(() => mockFirebaseNotificationManager.deviceToken)
          .thenAnswer((_) => Future.value('testToken'));

      expect(
          container.read(sessionsViewModelProvider).viewState, ViewState.idle);

      container.listen(sessionsViewModelProvider, listener.call,
          fireImmediately: true);
      final currState = container.read(sessionsViewModelProvider);

      await container.read(sessionsViewModelProvider.notifier).fetchSessions();

      verifyInOrder([
        () => listener(null, currState.copyWith(viewState: ViewState.idle)),
        () => listener(
            any(that: isA<SessionsUiState>()),
            any(
                that: isA<SessionsUiState>().having(
                    (s) => s.viewState, 'viewState', ViewState.loading))),
        () => listener(
              any(that: isA<SessionsUiState>()),
              any(
                  that: isA<SessionsUiState>()
                      .having(
                          (s) => s.viewState, 'viewState', ViewState.success)
                      .having((s) => s.sessions.isEmpty,
                          'Session list is not empty', false)),
            ),
      ]);
    });
  });
}
