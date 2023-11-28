import 'package:devfest23/core/data/data.dart';
import 'package:devfest23/core/exceptions/exceptions.dart';
import 'package:devfest23/core/ui_state_model/ui_state_model.dart';
import 'package:devfest23/features/onboarding/application/application.dart';
import 'package:devfest23/features/onboarding/application/auth/ui_state.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../commons.dart';

void main() {
  const mockEmail = 'sebastinesoacatp@gmail.com';
  const mockPassword = 'TestDevfest';
  final mockDevfestRepo = MockDevfestRepository();

  group('Auth view model test suite', () {
    late ProviderContainer container;
    late RiverpodListener<AuthUiState> listener;

    setUpAll(() => registerFallbackValue(AuthUiState.initial()));

    setUp(() {
      container = ProviderContainer(overrides: [
        devfestRepositoryProvider.overrideWithValue(mockDevfestRepo),
      ]);
      listener = RiverpodListener();
    });

    tearDown(() => container.dispose());

    test('Sign in with email and ticket id', () async {
      when(() => mockDevfestRepo.rsvpLogin(
            const LoginRequestDto(email: mockEmail, password: mockPassword),
          )).thenAnswer((_) => Future.value(const Right('my-id-token')));

      expect(container.read(authViewModelProvider).viewState, ViewState.idle);
      container
          .read(authViewModelProvider.notifier)
          .emailAddressOnChanged(mockEmail);
      container.read(authViewModelProvider.notifier).loginOnTap();
      expect(container.read(showFormErrorsProvider), true);

      container
          .read(authViewModelProvider.notifier)
          .passwordOnChanged(mockPassword);
      expect(container.read(authViewModelProvider).form.isValid, true);

      container.listen(authViewModelProvider, listener.call,
          fireImmediately: true);
      final currState = container.read(authViewModelProvider);

      await container.read(authViewModelProvider.notifier).loginOnTap();

      verifyInOrder([
        () => listener(null, currState.copyWith(viewState: ViewState.idle)),
        () => listener(
            any(that: isA<AuthUiState>()),
            any(
                that: isA<AuthUiState>().having((p0) => p0.viewState,
                    'current view state is loading', ViewState.loading))),
        () => listener(
            any(that: isA<AuthUiState>()),
            any(
                that: isA<AuthUiState>().having((p0) => p0.viewState,
                    'current view state is success', ViewState.success))),
        () => listener(
            any(that: isA<AuthUiState>()),
            any(
                that: isA<AuthUiState>().having((p0) => p0.viewState,
                    'current view state is idle', ViewState.idle))),
      ]);
    });

    test('User not registered sign in failure test', () async {
      when(() => mockDevfestRepo.rsvpLogin(
                const LoginRequestDto(email: mockEmail, password: mockPassword),
              ))
          .thenAnswer(
              (_) => Future.value(const Left(UserNotRegisteredException())));

      expect(container.read(authViewModelProvider).viewState, ViewState.idle);
      container
          .read(authViewModelProvider.notifier)
          .emailAddressOnChanged(mockEmail);
      container.read(authViewModelProvider.notifier).loginOnTap();
      expect(container.read(authViewModelProvider).showFormErrors, true);

      container
          .read(authViewModelProvider.notifier)
          .passwordOnChanged(mockPassword);
      expect(container.read(authViewModelProvider).form.isValid, true);

      container.listen(authViewModelProvider, listener.call,
          fireImmediately: true);
      final currState = container.read(authViewModelProvider);

      await container.read(authViewModelProvider.notifier).loginOnTap();

      verifyInOrder([
        () => listener(null, currState.copyWith(viewState: ViewState.idle)),
        () => listener(
            any(that: isA<AuthUiState>()),
            any(
                that: isA<AuthUiState>().having((p0) => p0.viewState,
                    'current view state is loading', ViewState.loading))),
        () => listener(
            any(that: isA<AuthUiState>()),
            any(
                that: isA<AuthUiState>()
                    .having((p0) => p0.viewState, 'current view state is error',
                        ViewState.error)
                    .having(
                        (p0) => p0.exception,
                        'Ensure the returned exception matches [UserNotRegisteredException]',
                        isA<UserNotRegisteredException>()))),
        () => listener(
            any(that: isA<AuthUiState>()),
            any(
                that: isA<AuthUiState>().having((p0) => p0.viewState,
                    'current view state is idle', ViewState.idle))),
      ]);
    });

    test('Invalid ticket id sign in failure test', () async {
      when(() => mockDevfestRepo.rsvpLogin(
                const LoginRequestDto(email: mockEmail, password: mockPassword),
              ))
          .thenAnswer(
              (_) => Future.value(const Left(InvalidTicketIdException())));
      expect(container.read(authViewModelProvider).viewState, ViewState.idle);
      container
          .read(authViewModelProvider.notifier)
          .emailAddressOnChanged(mockEmail);
      container.read(authViewModelProvider.notifier).loginOnTap();
      expect(container.read(authViewModelProvider).showFormErrors, true);

      container
          .read(authViewModelProvider.notifier)
          .passwordOnChanged(mockPassword);
      expect(container.read(authViewModelProvider).form.isValid, true);

      container.listen(authViewModelProvider, listener.call,
          fireImmediately: true);
      final currState = container.read(authViewModelProvider);

      await container.read(authViewModelProvider.notifier).loginOnTap();

      verifyInOrder([
        () => listener(null, currState.copyWith(viewState: ViewState.idle)),
        () => listener(
            any(that: isA<AuthUiState>()),
            any(
                that: isA<AuthUiState>().having((p0) => p0.viewState,
                    'current view state is loading', ViewState.loading))),
        () => listener(
            any(that: isA<AuthUiState>()),
            any(
                that: isA<AuthUiState>()
                    .having((p0) => p0.viewState, 'current view state is error',
                        ViewState.error)
                    .having(
                        (p0) => p0.exception,
                        'Ensure the returned exception matches [InvalidTicketIdException]',
                        isA<InvalidTicketIdException>()))),
        () => listener(
            any(that: isA<AuthUiState>()),
            any(
                that: isA<AuthUiState>().having((p0) => p0.viewState,
                    'current view state is idle', ViewState.idle))),
      ]);
    });

    test('Client/Basic sign in failure test', () async {
      when(() => mockDevfestRepo.rsvpLogin(
                const LoginRequestDto(email: mockEmail, password: mockPassword),
              ))
          .thenAnswer((_) => Future.value(const Left(ClientException(
              exceptionMessage: 'Something went wrong, please try again'))));
      expect(container.read(authViewModelProvider).viewState, ViewState.idle);
      container
          .read(authViewModelProvider.notifier)
          .emailAddressOnChanged(mockEmail);
      container.read(authViewModelProvider.notifier).loginOnTap();
      expect(container.read(authViewModelProvider).showFormErrors, true);

      container
          .read(authViewModelProvider.notifier)
          .passwordOnChanged(mockPassword);
      expect(container.read(authViewModelProvider).form.isValid, true);

      container.listen(authViewModelProvider, listener.call,
          fireImmediately: true);
      final currState = container.read(authViewModelProvider);

      await container.read(authViewModelProvider.notifier).loginOnTap();

      verifyInOrder([
        () => listener(null, currState.copyWith(viewState: ViewState.idle)),
        () => listener(
            any(that: isA<AuthUiState>()),
            any(
                that: isA<AuthUiState>().having((p0) => p0.viewState,
                    'current view state is loading', ViewState.loading))),
        () => listener(
            any(that: isA<AuthUiState>()),
            any(
                that: isA<AuthUiState>()
                    .having((p0) => p0.viewState, 'current view state is error',
                        ViewState.error)
                    .having(
                        (p0) => p0.exception,
                        'Ensure the returned exception matches [ClientException]',
                        isA<ClientException>()))),
        () => listener(
            any(that: isA<AuthUiState>()),
            any(
                that: isA<AuthUiState>().having((p0) => p0.viewState,
                    'current view state is idle', ViewState.idle))),
      ]);
    });
  });
}
