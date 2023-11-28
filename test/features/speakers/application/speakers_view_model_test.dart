import 'package:devfest23/core/constants.dart';
import 'package:devfest23/core/data/data.dart';
import 'package:devfest23/core/exceptions/client_exception.dart';
import 'package:devfest23/core/ui_state_model/ui_state_model.dart';
import 'package:devfest23/features/speakers/application/application.dart';
import 'package:devfest23/features/speakers/application/speakers/ui_state.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../commons.dart';

void main() {
  final mockDevfestRepo = MockDevfestRepository();

  group('Speakers view model test suite', () {
    late ProviderContainer container;
    late RiverpodListener<SpeakersUiState> listener;

    setUpAll(() => registerFallbackValue(const SpeakersUiState.initial()));

    setUp(() {
      container = ProviderContainer(overrides: [
        devfestRepositoryProvider.overrideWithValue(mockDevfestRepo),
      ]);
      listener = RiverpodListener();
    });

    tearDown(() => container.dispose());

    test('Fetch speakers success test', () async {
      when(() => mockDevfestRepo.fetchSpeakers()).thenAnswer(
        (_) => Future.value(Right(SpeakersResponseDto(speakers: [
          Speaker(
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
          ),
        ]))),
      );

      expect(
          container.read(speakersViewModelProvider).viewState, ViewState.idle);

      container.listen(speakersViewModelProvider, listener.call,
          fireImmediately: true);
      final currState = container.read(speakersViewModelProvider);

      await container.read(speakersViewModelProvider.notifier).fetchSpeakers();

      verifyInOrder([
        () => listener(null, currState.copyWith(viewState: ViewState.idle)),
        () => listener(
            any(that: isA<SpeakersUiState>()),
            any(
                that: isA<SpeakersUiState>().having(
                    (s) => s.viewState, 'viewState', ViewState.loading))),
        () => listener(
            any(that: isA<SpeakersUiState>()),
            any(
                that: isA<SpeakersUiState>()
                    .having((s) => s.viewState, 'viewState', ViewState.success)
                    .having((s) => s.speakers.isNotEmpty,
                        'Speakers is not empty', true))),
      ]);
    });

    testWidgets('Fetch speakers failure test', (widgetTester) async {
      when(() => mockDevfestRepo.fetchSpeakers()).thenAnswer(
        (_) => Future.value(
            const Left(ClientException(exceptionMessage: 'An error occurred'))),
      );

      expect(
          container.read(speakersViewModelProvider).viewState, ViewState.idle);

      container.listen(speakersViewModelProvider, listener.call,
          fireImmediately: true);
      final currState = container.read(speakersViewModelProvider);

      await widgetTester.pumpWidget(const UnitTestApp());
      await container.read(speakersViewModelProvider.notifier).fetchSpeakers();
      await widgetTester.pumpAndSettle();

      verifyInOrder([
        () => listener(null, currState.copyWith(viewState: ViewState.idle)),
        () => listener(
            any(that: isA<SpeakersUiState>()),
            any(
                that: isA<SpeakersUiState>().having(
                    (s) => s.viewState, 'viewState', ViewState.loading))),
        () => listener(
              any(that: isA<SpeakersUiState>()),
              any(
                  that: isA<SpeakersUiState>()
                      .having((s) => s.viewState, 'viewState', ViewState.error)
                      .having((s) => s.exception, 'exception',
                          isA<ClientException>())),
            ),
      ]);
    });

    test('Fetch session categories success test', () async {
      when(() => mockDevfestRepo.fetchSessionCategories()).thenAnswer(
        (_) => Future.value(const Right(CategoriesResponseDto(categories: [
          Category(
            name: 'Android',
            imageUrl: '',
          ),
        ]))),
      );

      expect(
          container.read(speakersViewModelProvider).categoriesUiState.viewState,
          ViewState.idle);

      container.listen(speakersViewModelProvider, listener.call,
          fireImmediately: true);
      final currState = container.read(speakersViewModelProvider);

      await container
          .read(speakersViewModelProvider.notifier)
          .fetchSessionCategories();

      verifyInOrder([
        () => listener(
            null,
            currState.copyWith(
                categoriesUiState: currState.categoriesUiState
                    .copyWith(viewState: ViewState.idle))),
        () => listener(
            any(that: isA<SpeakersUiState>()),
            any(
                that: isA<SpeakersUiState>().having(
                    (s) => s.categoriesUiState.viewState,
                    'viewState',
                    ViewState.loading))),
        () => listener(
            any(that: isA<SpeakersUiState>()),
            any(
                that: isA<SpeakersUiState>()
                    .having((s) => s.categoriesUiState.viewState, 'viewState',
                        ViewState.success)
                    .having((s) => s.categoriesUiState.categories.isNotEmpty,
                        'Categories is not empty', true))),
      ]);
    });

    testWidgets('Fetch session categories failure test', (widgetTester) async {
      when(() => mockDevfestRepo.fetchSessionCategories()).thenAnswer(
        (_) => Future.value(
            const Left(ClientException(exceptionMessage: 'An error occurred'))),
      );

      expect(
          container.read(speakersViewModelProvider).categoriesUiState.viewState,
          ViewState.idle);

      container.listen(speakersViewModelProvider, listener.call,
          fireImmediately: true);
      final currState = container.read(speakersViewModelProvider);

      await widgetTester.pumpWidget(const UnitTestApp());
      await container
          .read(speakersViewModelProvider.notifier)
          .fetchSessionCategories();
      await widgetTester.pumpAndSettle();

      verifyInOrder([
        () => listener(
            null,
            currState.copyWith(
                categoriesUiState: currState.categoriesUiState
                    .copyWith(viewState: ViewState.idle))),
        () => listener(
            any(that: isA<SpeakersUiState>()),
            any(
                that: isA<SpeakersUiState>().having(
                    (s) => s.categoriesUiState.viewState,
                    'viewState',
                    ViewState.loading))),
        () => listener(
              any(that: isA<SpeakersUiState>()),
              any(
                  that: isA<SpeakersUiState>()
                      .having((s) => s.categoriesUiState.viewState, 'viewState',
                          ViewState.error)
                      .having((s) => s.categoriesUiState.exception, 'exception',
                          isA<ClientException>())),
            ),
      ]);
    });

    test('Filter speakers by category test', () {
      container
          .read(speakersViewModelProvider.notifier)
          .filterSpeakersByCategory('All Speakers');

      expect(container.read(speakersViewModelProvider).filteredSpeakers.isEmpty,
          true);
      expect(container.read(speakersViewModelProvider).selectedCategory,
          'All Speakers');

      container
          .read(speakersViewModelProvider.notifier)
          .filterSpeakersByCategory('Android');

      expect(container.read(speakersViewModelProvider).filteredSpeakers.isEmpty,
          true);
      expect(container.read(speakersViewModelProvider).selectedCategory,
          'Android');
    });
  });
}
