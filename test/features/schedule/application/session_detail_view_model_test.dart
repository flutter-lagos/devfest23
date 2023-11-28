import 'package:devfest23/core/constants.dart';
import 'package:devfest23/core/data/data.dart';
import 'package:devfest23/core/exceptions/exceptions.dart';
import 'package:devfest23/core/ui_state_model/ui_state_model.dart';
import 'package:devfest23/features/schedule/application/application.dart';
import 'package:devfest23/features/schedule/application/session_detail/ui_state.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../commons.dart';

void main() {
  final mockSession = Session(
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
  );
  final mockDevfestRepo = MockDevfestRepository();

  group('Session details view model test suite', () {
    late ProviderContainer container;
    late RiverpodListener<SessionDetailUiState> listener;

    setUpAll(() => registerFallbackValue(SessionDetailUiState.initial()));

    setUp(() {
      container = ProviderContainer(overrides: [
        devfestRepositoryProvider.overrideWithValue(mockDevfestRepo),
      ]);
      listener = RiverpodListener();
    });

    tearDown(() => container.dispose());

    test('Initialise session correctly test', () {
      container
          .read(sessionDetailsViewModelProvider.notifier)
          .initialiseSession(mockSession);

      expect(
          container.read(sessionDetailsViewModelProvider).session, mockSession);
    });

    test('Reserve mock session success test', () async {
      when(() => mockDevfestRepo.addToRSVP(
              RSVPSessionRequestDto(sessionId: mockSession.sessionId)))
          .thenAnswer((_) => Future.value(const Right(null)));

      container
          .read(sessionDetailsViewModelProvider.notifier)
          .initialiseSession(mockSession);

      expect(container.read(sessionDetailsViewModelProvider).viewState,
          ViewState.idle);

      container.listen(sessionDetailsViewModelProvider, listener.call,
          fireImmediately: true);
      final currState = container.read(sessionDetailsViewModelProvider);

      await container
          .read(sessionDetailsViewModelProvider.notifier)
          .reserveSessionOnTap(false);

      verifyInOrder([
        () => listener(
            null,
            currState.copyWith(
                viewState: ViewState.idle, session: mockSession)),
        () => listener(
            any(that: isA<SessionDetailUiState>()),
            any(
                that: isA<SessionDetailUiState>().having(
                    (s) => s.viewState, 'viewState', ViewState.loading))),
        () => listener(
            any(that: isA<SessionDetailUiState>()),
            any(
                that: isA<SessionDetailUiState>().having(
                    (s) => s.viewState, 'viewState', ViewState.success))),
      ]);
    });

    testWidgets('Reserve mock session failure test', (widgetTester) async {
      when(() => mockDevfestRepo.addToRSVP(
              RSVPSessionRequestDto(sessionId: mockSession.sessionId)))
          .thenAnswer((_) => Future.value(const Left(
              ClientException(exceptionMessage: 'Reserve session failed'))));

      container
          .read(sessionDetailsViewModelProvider.notifier)
          .initialiseSession(mockSession);

      expect(container.read(sessionDetailsViewModelProvider).viewState,
          ViewState.idle);

      container.listen(sessionDetailsViewModelProvider, listener.call,
          fireImmediately: true);
      final currState = container.read(sessionDetailsViewModelProvider);

      await widgetTester.pumpWidget(const UnitTestApp());
      await container
          .read(sessionDetailsViewModelProvider.notifier)
          .reserveSessionOnTap(false);
      await widgetTester.pumpAndSettle();

      verifyInOrder([
        () => listener(
            null,
            currState.copyWith(
                viewState: ViewState.idle, session: mockSession)),
        () => listener(
            any(that: isA<SessionDetailUiState>()),
            any(
                that: isA<SessionDetailUiState>().having(
                    (s) => s.viewState, 'viewState', ViewState.loading))),
        () => listener(
            any(that: isA<SessionDetailUiState>()),
            any(
                that: isA<SessionDetailUiState>()
                    .having((s) => s.viewState, 'viewState', ViewState.error))),
      ]);
    });

    test('Reserve mock session success test for RSVPed User', () async {
      when(() => mockDevfestRepo.removeFromRSVP(
              RSVPSessionRequestDto(sessionId: mockSession.sessionId)))
          .thenAnswer((_) => Future.value(const Right(null)));

      container
          .read(sessionDetailsViewModelProvider.notifier)
          .initialiseSession(mockSession);

      expect(container.read(sessionDetailsViewModelProvider).viewState,
          ViewState.idle);

      container.listen(sessionDetailsViewModelProvider, listener.call,
          fireImmediately: true);
      final currState = container.read(sessionDetailsViewModelProvider);

      await container
          .read(sessionDetailsViewModelProvider.notifier)
          .reserveSessionOnTap(true);

      verifyInOrder([
        () => listener(
            null,
            currState.copyWith(
                viewState: ViewState.idle, session: mockSession)),
        () => listener(
            any(that: isA<SessionDetailUiState>()),
            any(
                that: isA<SessionDetailUiState>().having(
                    (s) => s.viewState, 'viewState', ViewState.loading))),
        () => listener(
            any(that: isA<SessionDetailUiState>()),
            any(
                that: isA<SessionDetailUiState>().having(
                    (s) => s.viewState, 'viewState', ViewState.success))),
      ]);
    });

    testWidgets('Reserve mock session failure test for RSVPed user',
        (widgetTester) async {
      when(() => mockDevfestRepo.removeFromRSVP(
              RSVPSessionRequestDto(sessionId: mockSession.sessionId)))
          .thenAnswer((_) => Future.value(const Left(
              ClientException(exceptionMessage: 'Reserve session failed'))));

      container
          .read(sessionDetailsViewModelProvider.notifier)
          .initialiseSession(mockSession);

      expect(container.read(sessionDetailsViewModelProvider).viewState,
          ViewState.idle);

      container.listen(sessionDetailsViewModelProvider, listener.call,
          fireImmediately: true);
      final currState = container.read(sessionDetailsViewModelProvider);

      await widgetTester.pumpWidget(const UnitTestApp());
      await container
          .read(sessionDetailsViewModelProvider.notifier)
          .reserveSessionOnTap(true);
      await widgetTester.pumpAndSettle();

      verifyInOrder([
        () => listener(
            null,
            currState.copyWith(
                viewState: ViewState.idle, session: mockSession)),
        () => listener(
            any(that: isA<SessionDetailUiState>()),
            any(
                that: isA<SessionDetailUiState>().having(
                    (s) => s.viewState, 'viewState', ViewState.loading))),
        () => listener(
            any(that: isA<SessionDetailUiState>()),
            any(
                that: isA<SessionDetailUiState>()
                    .having((s) => s.viewState, 'viewState', ViewState.error))),
      ]);
    });
  });
}
