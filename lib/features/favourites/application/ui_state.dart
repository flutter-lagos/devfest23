import 'package:devfest23/core/exceptions/exceptions.dart';

import '../../../core/data/data.dart';
import '../../../core/ui_state_model/ui_state_model.dart';

final class RSVPSessionsUiState extends DevfestUiState {
  final List<Session> sessions;

  const RSVPSessionsUiState({
    super.viewState,
    super.exception,
    required this.sessions,
  });

  const RSVPSessionsUiState.initial()
      : this(
          viewState: ViewState.idle,
          exception: const EmptyException(),
          sessions: const [],
        );

  RSVPSessionsUiState copyWith({
    ViewState? viewState,
    DevfestException? exception,
    List<Session>? sessions,
  }) {
    return RSVPSessionsUiState(
      viewState: viewState ?? this.viewState,
      sessions: sessions ?? this.sessions,
      exception: exception ?? this.exception,
    );
  }

  @override
  List<Object?> get props => [...super.props, sessions];
}
