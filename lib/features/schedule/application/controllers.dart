import 'package:devfest23/core/data/data.dart';
import 'package:devfest23/features/schedule/application/application.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final sessionsProvider = Provider.autoDispose<List<Session>>((ref) {
  return ref.watch(scheduleViewModelProvider.select((value) => value.sessions));
});

final sessionProvider = Provider.autoDispose<Session>((ref) {
  return ref
      .watch(sessionDetailsViewModelProvider.select((value) => value.session));
});
