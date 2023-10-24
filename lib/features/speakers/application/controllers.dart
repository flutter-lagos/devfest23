import 'package:devfest23/core/data/data.dart';
import 'package:devfest23/features/speakers/application/view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// final speakerCategoriesProvider = Provider.autoDispose<List<String>>((ref) {
//   return ref.watch(speakersViewModelProvider.select((value) => value.speakers));
// });

final speakersProvider = Provider.autoDispose<List<Speaker>>((ref) {
  return ref.watch(speakersViewModelProvider.select((value) => value.speakers));
});
