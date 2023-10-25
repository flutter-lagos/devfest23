import 'package:devfest23/core/ui_state_model/ui_state_model.dart';

import '../../../core/data/data.dart';
import 'ui_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SpeakersViewModel extends StateNotifier<SpeakersUiState> {
  final DevfestRepository _repo;

  SpeakersViewModel(this._repo) : super(const SpeakersUiState.initial());

  Future<void> fetchSpeakers() async {
    await launch(state.ref, (model) async {
      state = model.setState(state.copyWith(viewState: ViewState.loading));
      final result = await _repo.fetchSpeakers();

      state = model.setState(
        result.fold(
          (left) => state.copyWith(viewState: ViewState.error, exception: left),
          (right) => state.copyWith(
            viewState: ViewState.success,
            speakers: right.speakers,
          ),
        ),
      );
    });
  }
}

final speakersViewModelProvider =
    StateNotifierProvider.autoDispose<SpeakersViewModel, SpeakersUiState>(
  (ref) => SpeakersViewModel(ref.read(devfestRepositoryProvider)),
);
