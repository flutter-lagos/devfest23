import 'package:devfest23/core/ui_state_model/ui_state_model.dart';
import 'package:devfest23/features/profile/application/ui_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/data/data.dart';

class ProfileViewModel extends StateNotifier<ProfileUiState> {
  final DevfestRepository _repo;

  ProfileViewModel(this._repo) : super(const ProfileUiState.initial());

  Future<void> logout() async {
    await launch(state.ref, (model) async {
      state = model.setState(state.copyWith(viewState: ViewState.loading));
      final result = await _repo.logout();

      state = model.setState(result.fold(
        (left) => state.copyWith(viewState: ViewState.error, exception: left),
        (right) => state.copyWith(viewState: ViewState.success),
      ));
    });

    state = state.copyWith(viewState: ViewState.idle);
  }
}

final profileViewModelProvider =
    StateNotifierProvider.autoDispose<ProfileViewModel, ProfileUiState>(
  (ref) => ProfileViewModel(ref.read(devfestRepositoryProvider)),
);
