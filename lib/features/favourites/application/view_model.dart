import 'package:devfest23/features/favourites/application/ui_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/data/data.dart';
import '../../../core/ui_state_model/ui_state_model.dart';

class RSVPSessionsViewModel extends StateNotifier<RSVPSessionsUiState> {
  final DevfestRepository _repo;

  RSVPSessionsViewModel(this._repo)
      : super(const RSVPSessionsUiState.initial());

  Future<void> fetchRSVPSessions() async {
    await launch(state.ref, (model) async {
      state = model.setState(state.copyWith(viewState: ViewState.loading));
      final result = await _repo.fetchRSVPSessions();

      state = model.setState(
        result.fold(
          (left) => state.copyWith(viewState: ViewState.error, exception: left),
          (right) => state.copyWith(
              viewState: ViewState.success, sessions: right.sessions),
        ),
      );
    });
  }
}

final rsvpSessionsViewModelProvider = StateNotifierProvider.autoDispose<
    RSVPSessionsViewModel, RSVPSessionsUiState>(
  (ref) => RSVPSessionsViewModel(ref.read(devfestRepositoryProvider)),
);
