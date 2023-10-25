import 'package:devfest23/core/exceptions/exceptions.dart';
import 'package:devfest23/core/ui_state_model/ui_state_model.dart';

import '../../../core/data/data.dart';

final class SpeakersUiState extends DevfestUiState {
  final List<Speaker> speakers;

  const SpeakersUiState({
    super.viewState,
    super.exception,
    required this.speakers,
  });

  const SpeakersUiState.initial()
      : this(
          viewState: ViewState.idle,
          exception: const EmptyException(),
          speakers: const [],
        );

  SpeakersUiState copyWith({
    ViewState? viewState,
    DevfestException? exception,
    List<Speaker>? speakers,
  }) {
    return SpeakersUiState(
      viewState: viewState ?? this.viewState,
      speakers: speakers ?? this.speakers,
      exception: exception ?? this.exception,
    );
  }

  @override
  List<Object?> get props => [...super.props, speakers];
}
