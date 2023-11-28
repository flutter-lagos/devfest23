import 'package:devfest23/core/data/data.dart';
import 'package:devfest23/core/exceptions/client_exception.dart';
import 'package:devfest23/core/ui_state_model/ui_state_model.dart';
import 'package:devfest23/features/profile/application/ui_state.dart';
import 'package:devfest23/features/profile/application/view_model.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../commons.dart';

void main() {
  final mockDevfestRepo = MockDevfestRepository();

  group('Profile view model test suite', () {
    late ProviderContainer container;
    late RiverpodListener<ProfileUiState> listener;

    setUpAll(() => registerFallbackValue(const ProfileUiState.initial()));

    setUp(() {
      container = ProviderContainer(overrides: [
        devfestRepositoryProvider.overrideWithValue(mockDevfestRepo),
      ]);
      listener = RiverpodListener();
    });

    tearDown(() => container.dispose());

    test('Logout success test', () async {
      when(() => mockDevfestRepo.logout())
          .thenAnswer((_) => Future.value(const Right(null)));

      expect(
          container.read(profileViewModelProvider).viewState, ViewState.idle);

      container.listen(profileViewModelProvider, listener.call,
          fireImmediately: true);
      final currState = container.read(profileViewModelProvider);

      await container.read(profileViewModelProvider.notifier).logout();

      verifyInOrder([
        () => listener(null, currState.copyWith(viewState: ViewState.idle)),
        () => listener(
            any(that: isA<ProfileUiState>()),
            any(
                that: isA<ProfileUiState>().having(
                    (s) => s.viewState, 'viewState', ViewState.loading))),
        () => listener(
            any(that: isA<ProfileUiState>()),
            any(
                that: isA<ProfileUiState>().having(
                    (s) => s.viewState, 'viewState', ViewState.success))),
      ]);
    });

    testWidgets('Logout failure test', (widgetTester) async {
      when(() => mockDevfestRepo.logout()).thenAnswer((_) => Future.value(
          const Left(ClientException(exceptionMessage: 'Logout failed'))));

      expect(
          container.read(profileViewModelProvider).viewState, ViewState.idle);

      container.listen(profileViewModelProvider, listener.call,
          fireImmediately: true);
      final currState = container.read(profileViewModelProvider);

      await widgetTester.pumpWidget(const UnitTestApp());
      await container.read(profileViewModelProvider.notifier).logout();
      await widgetTester.pumpAndSettle();

      verifyInOrder([
        () => listener(null, currState.copyWith(viewState: ViewState.idle)),
        () => listener(
            any(that: isA<ProfileUiState>()),
            any(
                that: isA<ProfileUiState>().having(
                    (s) => s.viewState, 'viewState', ViewState.loading))),
        () => listener(
            any(that: isA<ProfileUiState>()),
            any(
                that: isA<ProfileUiState>()
                    .having((s) => s.viewState, 'viewState', ViewState.error))),
      ]);
    });
  });
}
