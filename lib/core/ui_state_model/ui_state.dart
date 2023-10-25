import 'package:devfest23/core/exceptions/exceptions.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../router/module_provider.dart';
import '../router/navigator.dart';
import 'view_state.dart';

typedef DevfestUiStateRef<T extends DevfestUiState> = List<T>;

@immutable
abstract base class DevfestUiState extends Equatable {
  const DevfestUiState({
    this.viewState = ViewState.idle,
    this.exception = const EmptyException(),
  });

  final ViewState viewState;
  final DevfestException exception;

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [viewState, exception];
}

Future<void> launch<E extends DevfestUiState>(
  DevfestUiStateRef<E> model,
  Future<void> Function(DevfestUiStateRef<E> model) function, {
  bool displayError = true,
}) async {
  await Future.sync(() => function(model));

  if (model.isEmpty || !displayError) return;
  model._state.displayError();
}

extension DevfestUiStateX<T extends DevfestUiState> on T {
  // provides an instance we can update since lists are passed by reference in dart
  DevfestUiStateRef<T> get ref => [this];

  void displayError() async {
    if (viewState != ViewState.error) return;
    assert(exception is! EmptyException, 'Please pass appropriate exception');

    final context = AppNavigator.getKey(Module.general).currentContext!;

    final snackBar = SnackBar(
      backgroundColor: Colors.red,
      content: Text(exception.toString()),
    );

    ScaffoldMessenger.maybeOf(context)?.showSnackBar(snackBar);
  }
}

extension DevfestUiStateRefX<T extends DevfestUiState> on DevfestUiStateRef<T> {
  DevfestUiStateRef<T> _assign(T value) => this..insert(0, value);

  T get _state => elementAt(0);

  T setState(T? value) => _assign(value ?? this._state)._state;
}
