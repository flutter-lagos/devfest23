import 'package:devfest23/core/exceptions/exceptions.dart';
import 'package:devfest23/core/ui_state_model/ui_state_model.dart';
import 'package:devfest23/features/onboarding/application/auth/auth_value_objects.dart';

final class AuthUiState extends DevfestUiState {
  final LoginForm form;
  final bool showFormErrors;

  const AuthUiState({
    required super.viewState,
    required super.exception,
    required this.form,
    required this.showFormErrors,
  });

  AuthUiState.initial()
      : this(
          viewState: ViewState.idle,
          exception: const EmptyException(),
          form: LoginForm.empty(),
          showFormErrors: false,
        );

  AuthUiState copyWith({
    ViewState? viewState,
    DevfestException? exception,
    LoginForm? form,
    bool? showFormErrors,
  }) {
    return AuthUiState(
      viewState: viewState ?? this.viewState,
      exception: exception ?? this.exception,
      form: form ?? this.form,
      showFormErrors: showFormErrors ?? this.showFormErrors,
    );
  }

  @override
  List<Object?> get props => [...super.props, form, showFormErrors];
}
