import 'package:devfest23/core/data/data.dart';
import 'package:devfest23/features/schedule/application/application.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants.dart';

final allSessionsProviderProvider = Provider.autoDispose<List<Session>>((ref) {
  return ref.watch(scheduleViewModelProvider.select((value) => value.sessions));
});

final day1SessionsProvider = Provider.autoDispose<List<Session>>((ref) {
  return ref
      .watch(scheduleViewModelProvider.select((value) => value.sessions))
      .where((element) =>
          element.sessionDate.difference(Constants.day1).inDays == 0)
      .toList()
    ..sort((a, b) => a.order.compareTo(b.order));
});

final day2SessionsProvider = Provider.autoDispose<List<Session>>((ref) {
  return ref
      .watch(scheduleViewModelProvider.select((value) => value.sessions))
      .where((element) =>
          element.sessionDate.difference(Constants.day2).inDays == 0)
      .toList()
    ..sort((a, b) => a.order.compareTo(b.order));
});

final day1RSVPSessionProvider = Provider.autoDispose<List<Session>>((ref) {
  return ref
      .watch(day1SessionsProvider)
      .where((element) => element.hasRsvped)
      .toList()
    ..sort((a, b) => a.order.compareTo(b.order));
});

final day2RSVPSessionProvider = Provider.autoDispose<List<Session>>((ref) {
  return ref
      .watch(day2SessionsProvider)
      .where((element) => element.hasRsvped)
      .toList()
    ..sort((a, b) => a.order.compareTo(b.order));
});

final sessionProvider = Provider.autoDispose<Session>((ref) {
  return ref
      .watch(sessionDetailsViewModelProvider.select((value) => value.session));
});
