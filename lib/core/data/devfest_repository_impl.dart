import 'package:devfest23/core/data/devfest_repository.dart';
import 'package:devfest23/core/data/dto/dto.dart';
import 'package:devfest23/core/exceptions/exceptions.dart';
import 'package:devfest23/core/network/network.dart';
import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
    final token = await FirebaseAuth.instance.currentUser?.getIdToken();
    final response = await client.call(
      path: 'https://addtousersessions-azqpniimiq-uc.a.run.app',
      options: Options(headers: {'Authorization': token}),
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
    final token = await FirebaseAuth.instance.currentUser?.getIdToken();
    final response = await client.call(
      path: 'https://getusersessions-azqpniimiq-uc.a.run.app',
      options: Options(headers: {'Authorization': token}),
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

  @override
  Future<EitherExceptionOr<String>> rsvpLogin(LoginRequestDto dto) async {
    try {
      final result = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: dto.email,
        password: dto.password,
      );

      if (result.user != null) {
        final idToken = await result.user!.getIdToken();
        return Right(idToken!);
      }

      return const Left(ClientException(
          exceptionMessage: 'Something went wrong, please try again'));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        return const Left(
          ClientException(
              exceptionMessage:
                  'Invalid email. Please ensure to enter a valid email address😉'),
        );
      }

      if (e.code == 'user-not-found') {
        return const Left(UserNotRegisteredException());
      }

      if (e.code == 'wrong-password') {
        return const Left(InvalidTicketIdException());
      }
    }

    return const Left(ClientException(
        exceptionMessage: 'Something went wrong, please try again'));
  }

  @override
  Future<EitherExceptionOr<void>> logout() async {
    final result = await FirebaseAuth.instance.signOut();
    return Right(result);
  }
}
