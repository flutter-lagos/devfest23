import 'package:devfest23/core/exceptions/devfest_exception.dart';
import 'package:devfest23/core/exceptions/empty_exception.dart';
import 'package:devfest23/core/ui_state_model/ui_state_model.dart';

import '../../../../core/data/data.dart';

final class SessionsUiState extends DevfestUiState {
  final List<Session> sessions;

  const SessionsUiState({
    super.viewState,
    super.exception,
    required this.sessions,
  });

  const SessionsUiState.initial()
      : this(
          viewState: ViewState.idle,
          exception: const EmptyException(),
          sessions: const [],
        );

  SessionsUiState copyWith({
    ViewState? viewState,
    DevfestException? exception,
    List<Session>? sessions,
  }) {
    return SessionsUiState(
      sessions: sessions ?? this.sessions,
      viewState: viewState ?? this.viewState,
      exception: exception ?? this.exception,
    );
  }

  @override
  List<Object?> get props => [...super.props, sessions];
}
