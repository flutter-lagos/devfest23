import 'package:devfest23/core/data/data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'application.dart';

// final speakerCategoriesProvider = Provider.autoDispose<List<String>>((ref) {
//   return ref.watch(speakersViewModelProvider.select((value) => value.speakers));
// });

final allSpeakersProvider = Provider.autoDispose<List<Speaker>>((ref) {
  return ref.watch(speakersViewModelProvider.select((value) => value.speakers));
});

final speakersProvider = Provider.autoDispose<List<Speaker>>((ref) {
  return ref.watch(speakersViewModelProvider
              .select((value) => value.selectedCategory)) ==
          'All Speakers'
      ? ref.watch(speakersViewModelProvider.select((value) => value.speakers))
      : ref.watch(
          speakersViewModelProvider.select((value) => value.filteredSpeakers));
});

final categoriesProvider = Provider.autoDispose<List<Category>>((ref) {
  return ref.watch(speakersViewModelProvider
      .select((value) => value.categoriesUiState.categories));
});

final speakerProvider = Provider.autoDispose<Speaker>((ref) {
  return ref
      .watch(speakerDetailsViewModelProvider.select((value) => value.speaker));
});
