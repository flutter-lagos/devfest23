import 'package:devfest23/core/data/devfest_repository_impl.dart';
import 'package:devfest23/core/data/dto/dto.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../network/network.dart';

abstract interface class DevfestRepository {
  const DevfestRepository();

  Future<EitherExceptionOr<void>> logout();

  Future<EitherExceptionOr<String>> rsvpLogin(LoginRequestDto dto);

  Future<EitherExceptionOr<AgendaResponseDto>> fetchAgendas();

  Future<EitherExceptionOr<SpeakersResponseDto>> fetchSpeakers();

  Future<EitherExceptionOr<SessionsResponseDto>> fetchSessions();

  Future<EitherExceptionOr> addToRSVP(AddToRSVPRequestDto dto);

  Future<EitherExceptionOr> addMultipleRSVPs(AddMultipleRSVPRequestDto dto);

  Future<EitherExceptionOr<SessionsResponseDto>> fetchRSVPSessions();

  Future<EitherExceptionOr<CategoriesResponseDto>> fetchSessionCategories();
}

final devfestRepositoryProvider = Provider.autoDispose((ref) {
  return const DevfestRepositoryImplementation();
});
