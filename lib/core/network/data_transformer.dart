import 'package:devfest23/core/enums/status.dart';
import 'package:devfest23/core/exceptions/exceptions.dart';
import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/foundation.dart';

typedef EitherExceptionOr<T> = Either<DevfestException, T>;

Future<EitherExceptionOr<E>> processData<E>(
  E Function(dynamic data) transformer,
  EitherExceptionOr<Response?> response,
) async {
  if (response.isLeft) return Left(response.left);

  return await compute<dynamic, EitherExceptionOr<E>>(
    (data) => _transformResponse(data, (p0) => transformer(p0)),
    response.right!.data,
  );
}

EitherExceptionOr<E> _transformResponse<E>(
    dynamic data, E Function(dynamic) transform) {
  try {
    final json = data as Map<String, dynamic>;
    switch ((json['status'] as String).status) {
      case Status.success:
        return Right(transform(json['data']));
      case Status.error:
        return Left(ServerException.fromJson(json));
    }
  } on TypeError catch (e) {
    return Left(ObjectParseException(e.stackTrace));
  } on Exception catch (e) {
    return Left(ClientException(exceptionMessage: e.toString()));
  }
}
