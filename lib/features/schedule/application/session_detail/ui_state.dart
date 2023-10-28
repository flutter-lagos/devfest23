import 'package:devfest23/core/data/data.dart';
import 'package:devfest23/core/exceptions/exceptions.dart';
import 'package:devfest23/core/ui_state_model/ui_state_model.dart';

final class SessionDetailUiState extends DevfestUiState {
  final Session session;

  const SessionDetailUiState({
    required this.session,
    super.viewState,
    super.exception,
  });

  const SessionDetailUiState.initial()
      : this(
          session: const Session.empty(),
          viewState: ViewState.idle,
          exception: const EmptyException(),
        );

  SessionDetailUiState copyWith({
    ViewState? viewState,
    DevfestException? exception,
    Session? session,
  }) {
    return SessionDetailUiState(
      session: session ?? this.session,
      viewState: viewState ?? this.viewState,
      exception: exception ?? this.exception,
    );
  }

  @override
  List<Object?> get props => [...super.props, session];
}
