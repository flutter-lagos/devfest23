import 'package:devfest23/core/data/data.dart';
import 'package:devfest23/features/favourites/application/view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final rsvpSessionsProvider = Provider.autoDispose<List<Session>>((ref) {
  return ref
      .watch(rsvpSessionsViewModelProvider.select((value) => value.sessions));
});
