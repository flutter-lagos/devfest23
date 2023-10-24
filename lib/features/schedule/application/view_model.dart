import 'package:devfest23/core/ui_state_model/ui_state_model.dart';
import 'package:devfest23/features/schedule/application/ui_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/data/data.dart';

class ScheduleViewModel extends StateNotifier<ScheduleUiState> {
  final DevfestRepository _repo;

  ScheduleViewModel(this._repo) : super(const ScheduleUiState.initial());

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
    StateNotifierProvider.autoDispose<ScheduleViewModel, ScheduleUiState>(
  (ref) => ScheduleViewModel(ref.read(devfestRepositoryProvider)),
);
