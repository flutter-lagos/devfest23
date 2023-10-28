import 'package:devfest23/core/exceptions/exceptions.dart';
import 'package:devfest23/core/ui_state_model/ui_state_model.dart';

import '../../../../core/data/data.dart';

final class SpeakersUiState extends DevfestUiState {
  final List<Speaker> speakers;
  final List<Speaker> filteredSpeakers;
  final SpeakerCategoriesUiState categoriesUiState;
  final String selectedCategory;

  const SpeakersUiState({
    super.viewState,
    super.exception,
    required this.speakers,
    required this.filteredSpeakers,
    required this.categoriesUiState,
    required this.selectedCategory,
  });

  const SpeakersUiState.initial()
      : this(
          viewState: ViewState.idle,
          exception: const EmptyException(),
          speakers: const [],
          filteredSpeakers: const [],
          categoriesUiState: const SpeakerCategoriesUiState.initial(),
          selectedCategory: 'All Speakers',
        );

  SpeakersUiState copyWith({
    ViewState? viewState,
    DevfestException? exception,
    List<Speaker>? speakers,
    List<Speaker>? filteredSpeakers,
    SpeakerCategoriesUiState? categoriesUiState,
    String? selectedCategory,
  }) {
    return SpeakersUiState(
      viewState: viewState ?? this.viewState,
      speakers: speakers ?? this.speakers,
      filteredSpeakers: filteredSpeakers ?? this.filteredSpeakers,
      exception: exception ?? this.exception,
      categoriesUiState: categoriesUiState ?? this.categoriesUiState,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }

  @override
  List<Object?> get props => [
        ...super.props,
        speakers,
        filteredSpeakers,
        categoriesUiState,
        selectedCategory,
      ];
}

final class SpeakerCategoriesUiState extends DevfestUiState {
  final List<Category> categories;

  const SpeakerCategoriesUiState({
    super.viewState,
    super.exception,
    required this.categories,
  });

  const SpeakerCategoriesUiState.initial()
      : this(
          viewState: ViewState.idle,
          exception: const EmptyException(),
          categories: const [],
        );

  SpeakerCategoriesUiState copyWith({
    ViewState? viewState,
    DevfestException? exception,
    List<Category>? categories,
  }) {
    return SpeakerCategoriesUiState(
      categories: categories ?? this.categories,
      viewState: viewState ?? this.viewState,
      exception: exception ?? this.exception,
    );
  }

  @override
  List<Object?> get props => [...super.props, categories];
}
