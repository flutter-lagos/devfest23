import 'package:devfest23/core/exceptions/exceptions.dart';
import 'package:devfest23/core/ui_state_model/ui_state_model.dart';

final class ProfileUiState extends DevfestUiState {
  const ProfileUiState({
    required super.viewState,
    required super.exception,
  });

  const ProfileUiState.initial()
      : this(
          viewState: ViewState.idle,
          exception: const EmptyException(),
        );

  ProfileUiState copyWith({
    ViewState? viewState,
    DevfestException? exception,
  }) {
    return ProfileUiState(
      viewState: viewState ?? this.viewState,
      exception: exception ?? this.exception,
    );
  }

  @override
  List<Object?> get props => [...super.props];
}
