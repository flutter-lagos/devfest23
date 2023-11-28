import 'package:devfest23/core/constants.dart';
import 'package:devfest23/core/data/data.dart';
import 'package:devfest23/core/exceptions/exceptions.dart';
import 'package:devfest23/core/ui_state_model/ui_state_model.dart';
import 'package:devfest23/features/speakers/application/application.dart';
import 'package:devfest23/features/speakers/application/speaker_detail/ui_state.dart';
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
  final mockSpeaker = Speaker(
    twitter: '',
    github: '',
    role: '',
    organization: 'Test Org',
    name: 'Johnny Doe',
    bio: 'A successful software engineer',
    linkedIn: '',
    avatar: '',
    email: 'johndoe@gmail.com',
    order: 1,
    category: 'Android',
    currentSession: '',
    currentSessionId: '',
    sessionDate: Constants.day1,
  );
  final mockDevfestRepo = MockDevfestRepository();

  group('Speaker details view model test suite', () {
    late ProviderContainer container;
    late RiverpodListener<SpeakerDetailsUiState> listener;

    setUpAll(() => registerFallbackValue(SpeakerDetailsUiState.initial()));

    setUp(() {
      container = ProviderContainer(overrides: [
        devfestRepositoryProvider.overrideWithValue(mockDevfestRepo),
      ]);
      listener = RiverpodListener();
    });

    tearDown(() => container.dispose());

    test('Initialise speaker test', () {
      container
          .read(speakerDetailsViewModelProvider.notifier)
          .initialiseSpeaker(mockSpeaker);

      expect(
          container.read(speakerDetailsViewModelProvider).speaker, mockSpeaker);
    });

    test('Initialise session test', () {
      container
          .read(speakerDetailsViewModelProvider.notifier)
          .initialiseSession(mockSession);

      expect(
          container.read(speakerDetailsViewModelProvider).session, mockSession);
    });

    test('Remove rsvped session success test', () async {
      when(() => mockDevfestRepo.removeFromRSVP(
              RSVPSessionRequestDto(sessionId: mockSession.sessionId)))
          .thenAnswer((_) => Future.value(const Right(null)));

      container
          .read(speakerDetailsViewModelProvider.notifier)
          .initialiseSession(mockSession);

      expect(container.read(speakerDetailsViewModelProvider).viewState,
          ViewState.idle);

      container.listen(speakerDetailsViewModelProvider, listener.call,
          fireImmediately: true);
      final currState = container.read(speakerDetailsViewModelProvider);

      await container
          .read(speakerDetailsViewModelProvider.notifier)
          .reserveSessionOnTap(true);

      verifyInOrder([
        () => listener(null, currState.copyWith(viewState: ViewState.idle)),
        () => listener(
            any(that: isA<SpeakerDetailsUiState>()),
            any(
                that: isA<SpeakerDetailsUiState>().having(
                    (s) => s.viewState, 'viewState', ViewState.loading))),
        () => listener(
            any(that: isA<SpeakerDetailsUiState>()),
            any(
                that: isA<SpeakerDetailsUiState>().having(
                    (s) => s.viewState, 'viewState', ViewState.success))),
      ]);
    });

    testWidgets('Remove reserved sessions failure test', (widgetTester) async {
      when(() => mockDevfestRepo.removeFromRSVP(
              RSVPSessionRequestDto(sessionId: mockSession.sessionId)))
          .thenAnswer((_) => Future.value(const Left(
              ClientException(exceptionMessage: 'Reserve session failed'))));

      container
          .read(speakerDetailsViewModelProvider.notifier)
          .initialiseSession(mockSession);

      expect(container.read(speakerDetailsViewModelProvider).viewState,
          ViewState.idle);

      container.listen(speakerDetailsViewModelProvider, listener.call,
          fireImmediately: true);
      final currState = container.read(speakerDetailsViewModelProvider);

      await widgetTester.pumpWidget(const UnitTestApp());
      await container
          .read(speakerDetailsViewModelProvider.notifier)
          .reserveSessionOnTap(true);
      await widgetTester.pumpAndSettle();

      verifyInOrder([
        () => listener(null, currState.copyWith(viewState: ViewState.idle)),
        () => listener(
            any(that: isA<SpeakerDetailsUiState>()),
            any(
                that: isA<SpeakerDetailsUiState>().having(
                    (s) => s.viewState, 'viewState', ViewState.loading))),
        () => listener(
            any(that: isA<SpeakerDetailsUiState>()),
            any(
                that: isA<SpeakerDetailsUiState>()
                    .having((s) => s.viewState, 'viewState', ViewState.error)
                    .having((s) => s.exception, 'exception',
                        isA<ClientException>()))),
      ]);
    });

    test('Reserve session "has not rsvped" success test', () async {
      when(() => mockDevfestRepo.addToRSVP(
              RSVPSessionRequestDto(sessionId: mockSession.sessionId)))
          .thenAnswer((_) => Future.value(const Right(null)));

      container
          .read(speakerDetailsViewModelProvider.notifier)
          .initialiseSession(mockSession);

      expect(container.read(speakerDetailsViewModelProvider).viewState,
          ViewState.idle);

      container.listen(speakerDetailsViewModelProvider, listener.call,
          fireImmediately: true);
      final currState = container.read(speakerDetailsViewModelProvider);

      await container
          .read(speakerDetailsViewModelProvider.notifier)
          .reserveSessionOnTap(false);

      verifyInOrder([
        () => listener(null, currState.copyWith(viewState: ViewState.idle)),
        () => listener(
            any(that: isA<SpeakerDetailsUiState>()),
            any(
                that: isA<SpeakerDetailsUiState>().having(
                    (s) => s.viewState, 'viewState', ViewState.loading))),
        () => listener(
            any(that: isA<SpeakerDetailsUiState>()),
            any(
                that: isA<SpeakerDetailsUiState>().having(
                    (s) => s.viewState, 'viewState', ViewState.success))),
      ]);
    });

    testWidgets('Reserve session "has not rsvped" failure test',
        (widgetTester) async {
      when(() => mockDevfestRepo.addToRSVP(
              RSVPSessionRequestDto(sessionId: mockSession.sessionId)))
          .thenAnswer((_) => Future.value(const Left(
              ClientException(exceptionMessage: 'Reserve session failed'))));

      container
          .read(speakerDetailsViewModelProvider.notifier)
          .initialiseSession(mockSession);

      expect(container.read(speakerDetailsViewModelProvider).viewState,
          ViewState.idle);

      container.listen(speakerDetailsViewModelProvider, listener.call,
          fireImmediately: true);
      final currState = container.read(speakerDetailsViewModelProvider);

      await widgetTester.pumpWidget(const UnitTestApp());
      await container
          .read(speakerDetailsViewModelProvider.notifier)
          .reserveSessionOnTap(false);
      await widgetTester.pumpAndSettle();

      verifyInOrder([
        () => listener(null, currState.copyWith(viewState: ViewState.idle)),
        () => listener(
            any(that: isA<SpeakerDetailsUiState>()),
            any(
                that: isA<SpeakerDetailsUiState>().having(
                    (s) => s.viewState, 'viewState', ViewState.loading))),
        () => listener(
            any(that: isA<SpeakerDetailsUiState>()),
            any(
                that: isA<SpeakerDetailsUiState>()
                    .having((s) => s.viewState, 'viewState', ViewState.error)
                    .having((s) => s.exception, 'exception',
                        isA<ClientException>()))),
      ]);
    });
  });
}
