import 'package:devfest23/core/data/devfest_repository.dart';
import 'package:devfest23/core/data/dto/dto.dart';
import 'package:devfest23/core/network/network.dart';

final class DevfestRepositoryImplementation implements DevfestRepository {
  final DevfestNetworkClient client;

  const DevfestRepositoryImplementation([
    this.client = const DevfestNetworkClient(),
  ]);

  @override
  Future<EitherExceptionOr> addMultipleRSVPs(
      AddMultipleRSVPRequestDto dto) async {
    final response = await client.call(
      path: 'https://addmultipletousersessions-azqpniimiq-uc.a.run.app',
      method: RequestMethod.get,
    );

    return await processData((data) => null, response);
  }

  @override
  Future<EitherExceptionOr> addToRSVP(AddToRSVPRequestDto dto) async {
    final response = await client.call(
      path: 'https://addtousersessions-azqpniimiq-uc.a.run.app',
      method: RequestMethod.post,
      body: dto.toJson(),
    );

    return await processData((data) => null, response);
  }

  @override
  Future<EitherExceptionOr<AgendaResponseDto>> fetchAgendas() async {
    final response = await client.call(
      path: 'https://fetchagendas-azqpniimiq-uc.a.run.app',
      method: RequestMethod.get,
    );

    return await processData(AgendaResponseDto.fromJson, response);
  }

  @override
  Future<EitherExceptionOr<SessionsResponseDto>> fetchRSVPSessions() async {
    final response = await client.call(
      path: 'https://getusersessions-azqpniimiq-uc.a.run.app',
      method: RequestMethod.get,
    );

    return await processData(SessionsResponseDto.fromJson, response);
  }

  @override
  Future<EitherExceptionOr<SessionsResponseDto>> fetchSessions() async {
    final response = await client.call(
      path: 'https://fetchsessions-azqpniimiq-uc.a.run.app',
      method: RequestMethod.get,
    );

    return await processData(SessionsResponseDto.fromJson, response);
  }

  @override
  Future<EitherExceptionOr<SpeakersResponseDto>> fetchSpeakers() async {
    final response = await client.call(
      path: 'https://fetchspeakers-azqpniimiq-uc.a.run.app',
      method: RequestMethod.get,
    );

    return await processData(SpeakersResponseDto.fromJson, response);
  }

  @override
  Future<EitherExceptionOr<CategoriesResponseDto>>
      fetchSessionCategories() async {
    final response = await client.call(
      path: 'https://fetchcategories-azqpniimiq-uc.a.run.app',
      method: RequestMethod.get,
    );

    return await processData(CategoriesResponseDto.fromJson, response);
  }
}
