import 'package:devfest23/core/ui_state_model/ui_state_model.dart';

import '../../../../core/data/data.dart';
import 'auth_value_objects.dart';

import 'ui_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthViewModel extends StateNotifier<AuthUiState> {
  final DevfestRepository _repo;

  AuthViewModel(this._repo) : super(AuthUiState.initial());

  void emailAddressOnChanged(String input) {
    state = state.copyWith(
      form: state.form.copyWith(emailAddress: EmailAddress(input)),
    );
  }

  void passwordOnChanged(String input) {
    state = state.copyWith(
      form: state.form.copyWith(password: Password(input)),
    );
  }

  Future<void> loginOnTap() async {
    if (state.form.isValid) {
      await launch(state.ref, (model) async {
        state = model.setState(state.copyWith(viewState: ViewState.loading));
        final result = await _repo.rsvpLogin(state.form.toDto());

        state = model.setState(result.fold(
          (left) => state.copyWith(viewState: ViewState.error, exception: left),
          (right) => state.copyWith(viewState: ViewState.success),
        ));
      }, displayError: false);

      state = state.copyWith(viewState: ViewState.idle);
      return;
    }

    state = state.copyWith(showFormErrors: true);
  }
}

final authViewModelProvider =
    StateNotifierProvider.autoDispose<AuthViewModel, AuthUiState>(
  (ref) => AuthViewModel(ref.read(devfestRepositoryProvider)),
);
