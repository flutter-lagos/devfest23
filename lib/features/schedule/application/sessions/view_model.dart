import 'package:devfest23/core/ui_state_model/ui_state_model.dart';
import 'package:devfest23/features/schedule/application/sessions/ui_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/data/data.dart';

class SessionsViewModel extends StateNotifier<SessionsUiState> {
  final DevfestRepository _repo;

  SessionsViewModel(this._repo) : super(const SessionsUiState.initial());

  Future<void> fetchSessions() async {
    await launch(state.ref, (model) async {
      state = model.setState(state.copyWith(viewState: ViewState.loading));
      final result = await _repo.fetchSessions();

      state = model.setState(
        result.fold(
          (left) => state.copyWith(viewState: ViewState.error, exception: left),
          (right) => state.copyWith(
            viewState: ViewState.success,
            sessions: right.sessions,
          ),
        ),
      );
    });
  }
}

final scheduleViewModelProvider =
    StateNotifierProvider.autoDispose<SessionsViewModel, SessionsUiState>(
  (ref) => SessionsViewModel(ref.read(devfestRepositoryProvider)),
);
