import 'package:devfest23/core/data/data.dart';
import 'package:devfest23/core/ui_state_model/ui_state_model.dart';

import 'ui_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SessionDetailsViewModel extends StateNotifier<SessionDetailUiState> {
  final DevfestRepository _repo;

  SessionDetailsViewModel(this._repo) : super(SessionDetailUiState.initial());

  void initialiseSession(Session session) {
    state = state.copyWith(session: session);
  }

  Future<void> reserveSessionOnTap(bool hasRsvped) async {
    if (!hasRsvped) {
      await launch(state.ref, (model) async {
        state = model.setState(state.copyWith(viewState: ViewState.loading));
        final dto = RSVPSessionRequestDto(sessionId: state.session.sessionId);
        final result = await _repo.addToRSVP(dto);

        state = model.setState(result.fold(
          (left) => state.copyWith(viewState: ViewState.error, exception: left),
          (right) => state.copyWith(
            viewState: ViewState.success,
            session: state.session.copyWith(
              availableSeats: state.session.availableSeats - 1,
              hasRsvped: true,
            ),
          ),
        ));
      });

      state = state.copyWith(viewState: ViewState.idle);
      return;
    }

    await launch(state.ref, (model) async {
      state = model.setState(state.copyWith(viewState: ViewState.loading));
      final dto = RSVPSessionRequestDto(sessionId: state.session.sessionId);
      final result = await _repo.removeFromRSVP(dto);

      state = model.setState(
        result.fold(
          (left) => state.copyWith(viewState: ViewState.error, exception: left),
          (right) => state.copyWith(
            viewState: ViewState.success,
            session: state.session.copyWith(
              availableSeats: state.session.availableSeats + 1,
              hasRsvped: false,
            ),
          ),
        ),
      );
    });

    state = state.copyWith(viewState: ViewState.idle);
  }
}

final sessionDetailsViewModelProvider = StateNotifierProvider.autoDispose<
    SessionDetailsViewModel, SessionDetailUiState>(
  (ref) => SessionDetailsViewModel(ref.read(devfestRepositoryProvider)),
);
