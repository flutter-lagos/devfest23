import 'package:devfest23/core/data/devfest_repository.dart';
import 'package:devfest23/core/data/dto/dto.dart';
import 'package:devfest23/core/network/network.dart';

final class DevfestRepositoryImplementation implements DevfestRepository {
  final DevfestNetworkClient client;

  const DevfestRepositoryImplementation([
    this.client = const DevfestNetworkClient(),
  ]);

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

    return await processData(
        (data) => AgendaResponseDto.fromJson(data), response);
  }

  @override
  Future<EitherExceptionOr> fetchRSVP() async {
    final response = await client.call(
      path: 'https://getusersessions-azqpniimiq-uc.a.run.app',
      method: RequestMethod.get,
    );

    return await processData((data) => null, response);
  }

  @override
  Future<EitherExceptionOr<SessionsResponseDto>> fetchSessions() async {
    final response = await client.call(
      path: 'https://fetchsessions-azqpniimiq-uc.a.run.app',
      method: RequestMethod.get,
    );

    return await processData(
        (data) => SessionsResponseDto.fromJson(data), response);
  }

  @override
  Future<EitherExceptionOr<SpeakersResponseDto>> fetchSpeakers() async {
    final response = await client.call(
      path: 'https://fetchspeakers-azqpniimiq-uc.a.run.app',
      method: RequestMethod.get,
    );

    return await processData(
        (data) => SpeakersResponseDto.fromJson(data), response);
  }
}
