import 'package:devfest23/core/services/firebase_notification_manager.dart';
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

      final [sessionResult, rsvpResult, _] = await Future.wait([
        _repo.fetchSessions(),
        _repo.fetchRSVPSessions(),
        _repo.updateUserDeviceToken(
          UpdateTokenRequestDto(
            deviceToken: await FirebaseNotificationManager().deviceToken ?? '',
          ),
        ),
      ]);

      if (sessionResult.isLeft) {
        state = model.setState(
          state.copyWith(
              viewState: ViewState.error, exception: sessionResult.left),
        );
        return;
      }

      if (rsvpResult.isLeft) {
        state = model.setState(
          state.copyWith(
              viewState: ViewState.error, exception: rsvpResult.left),
        );
        return;
      }

      List<Session> sessions =
          (sessionResult.right as SessionsResponseDto).sessions;
      final rsvpSessions = (rsvpResult.right as List<String>);

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
