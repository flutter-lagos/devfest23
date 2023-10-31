import 'package:devfest23/core/data/data.dart';
import 'package:devfest23/core/exceptions/exceptions.dart';
import 'package:devfest23/core/ui_state_model/ui_state_model.dart';

final class SpeakerDetailsUiState extends DevfestUiState {
  final Speaker speaker;
  final Session session;

  const SpeakerDetailsUiState({
    super.viewState,
    super.exception,
    required this.speaker,
    required this.session,
  });

  SpeakerDetailsUiState.initial()
      : this(
          viewState: ViewState.idle,
          exception: const EmptyException(),
          speaker: Speaker.empty(),
          session: Session.empty(),
        );

  SpeakerDetailsUiState copyWith({
    ViewState? viewState,
    DevfestException? exception,
    Speaker? speaker,
    Session? session,
  }) {
    return SpeakerDetailsUiState(
      speaker: speaker ?? this.speaker,
      viewState: viewState ?? this.viewState,
      exception: exception ?? this.exception,
      session: session ?? this.session,
    );
  }

  @override
  List<Object?> get props => [...super.props, speaker, session];
}
