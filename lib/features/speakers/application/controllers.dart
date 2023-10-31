import 'package:devfest23/core/data/data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants.dart';
import 'application.dart';

final day1AllSpeakersProvider = Provider.autoDispose<List<Speaker>>((ref) {
  return ref
      .watch(speakersViewModelProvider.select((value) => value.speakers))
      .where((element) =>
          element.sessionDate.difference(Constants.day1).inDays == 0)
      .toList();
});

final day2AllSpeakersProvider = Provider.autoDispose<List<Speaker>>((ref) {
  return ref
      .watch(speakersViewModelProvider.select((value) => value.speakers))
      .where((element) =>
          element.sessionDate.difference(Constants.day2).inDays == 0)
      .toList();
});

final day1FilteredSpeakersProvider = Provider.autoDispose<List<Speaker>>((ref) {
  return ref
      .watch(
          speakersViewModelProvider.select((value) => value.filteredSpeakers))
      .where((element) =>
          element.sessionDate.difference(Constants.day1).inDays == 0)
      .toList();
});

final day2FilteredSpeakersProvider = Provider.autoDispose<List<Speaker>>((ref) {
  return ref
      .watch(
          speakersViewModelProvider.select((value) => value.filteredSpeakers))
      .where((element) =>
          element.sessionDate.difference(Constants.day2).inDays == 0)
      .toList();
});

final day1SpeakersProvider = Provider.autoDispose<List<Speaker>>((ref) {
  return ref.watch(speakersViewModelProvider
              .select((value) => value.selectedCategory)) ==
          'All Speakers'
      ? ref.watch(day1AllSpeakersProvider)
      : ref.watch(day1FilteredSpeakersProvider);
});

final day2SpeakersProvider = Provider.autoDispose<List<Speaker>>((ref) {
  return ref.watch(speakersViewModelProvider
              .select((value) => value.selectedCategory)) ==
          'All Speakers'
      ? ref.watch(day2AllSpeakersProvider)
      : ref.watch(day2FilteredSpeakersProvider);
});

final categoriesProvider = Provider.autoDispose<List<Category>>((ref) {
  return ref.watch(speakersViewModelProvider
      .select((value) => value.categoriesUiState.categories));
});

final speakerProvider = Provider.autoDispose<Speaker>((ref) {
  return ref
      .watch(speakerDetailsViewModelProvider.select((value) => value.speaker));
});
