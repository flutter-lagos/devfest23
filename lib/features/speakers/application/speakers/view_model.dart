import 'package:devfest23/core/ui_state_model/ui_state_model.dart';

import '../../../../core/data/data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'ui_state.dart';

class SpeakersViewModel extends StateNotifier<SpeakersUiState> {
  final DevfestRepository _repo;

  SpeakersViewModel(this._repo) : super(const SpeakersUiState.initial());

  void filterSpeakersByCategory(String categoryName) {
    state = state.copyWith(
      filteredSpeakers: categoryName == 'All Speakers'
          ? []
          : state.speakers
              .toList()
              .where((element) => element.category == categoryName)
              .toList(),
      selectedCategory: categoryName,
    );
  }

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

  Future<void> fetchSessionCategories() async {
    await launch(state.categoriesUiState.ref, (model) async {
      state = state.copyWith(
          categoriesUiState: model.setState(
        state.categoriesUiState.copyWith(viewState: ViewState.loading),
      ));
      final result = await _repo.fetchSessionCategories();

      state = state.copyWith(
          categoriesUiState: model.setState(
        result.fold(
          (left) => state.categoriesUiState
              .copyWith(viewState: ViewState.error, exception: left),
          (right) => state.categoriesUiState.copyWith(
              viewState: ViewState.success, categories: right.categories),
        ),
      ));
    });
  }
}

final speakersViewModelProvider =
    StateNotifierProvider.autoDispose<SpeakersViewModel, SpeakersUiState>(
  (ref) => SpeakersViewModel(ref.read(devfestRepositoryProvider)),
);
