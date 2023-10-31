import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/ui_state_model/ui_state_model.dart';
import 'application.dart';

final showFormErrorsProvider = Provider.autoDispose<bool>((ref) {
  return ref
      .watch(authViewModelProvider.select((value) => value.showFormErrors));
});

final authIsLoadingProvider = Provider.autoDispose<bool>((ref) {
  return ref.watch(authViewModelProvider.select((value) => value.viewState)) ==
      ViewState.loading;
});
