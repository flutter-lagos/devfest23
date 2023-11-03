import 'package:devfest23/core/ui_state_model/ui_state_model.dart';
import 'package:devfest23/features/schedule/application/sessions/ui_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/data/data.dart';

class SessionsViewModel extends StateNotifier<SessionsUiState> {
  final DevfestRepository _repo;

  SessionsViewModel(this._repo) : super(const SessionsUiState.initial());

  Future<void> fetchSessions() async {
    await launch(state.ref, (model) async {
      state = model.setState(state.copyWith(viewState: ViewState.loading));
      if (FirebaseAuth.instance.currentUser == null) {
        final result = await _repo.fetchSessions();

        state = model.setState(
          result.fold(
            (left) =>
                state.copyWith(viewState: ViewState.error, exception: left),
            (right) => state.copyWith(
              viewState: ViewState.success,
              sessions: right.sessions,
            ),
          ),
        );
        return;
      }

      final results = await Future.wait([
        _repo.fetchSessions(),
        _repo.fetchRSVPSessions(),
      ]);

      if (results[0].isLeft) {
        state = model.setState(
          state.copyWith(
              viewState: ViewState.error, exception: results[0].left),
        );
        return;
      }

      if (results[1].isLeft) {
        state = model.setState(
          state.copyWith(
              viewState: ViewState.error, exception: results[1].left),
        );
        return;
      }

      List<Session> sessions =
          (results[0].right as SessionsResponseDto).sessions;
      final rsvpSessions = (results[1].right as List<String>);

      for (final sessionId in rsvpSessions) {
        sessions = sessions.map((e) {
          if (e.sessionId == sessionId) {
            return e.copyWith(hasRsvped: true);
          }
          return e;
        }).toList();
      }

      state = model.setState(
        state.copyWith(viewState: ViewState.success, sessions: sessions),
      );
    });
  }
}

final scheduleViewModelProvider =
    StateNotifierProvider.autoDispose<SessionsViewModel, SessionsUiState>(
  (ref) => SessionsViewModel(ref.read(devfestRepositoryProvider)),
);
