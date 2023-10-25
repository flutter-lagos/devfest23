import 'dart:io';
import 'package:devfest23/core/exceptions/exceptions.dart';
import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/io.dart';

class DevfestNetworkClient {
  const DevfestNetworkClient();

  Dio get _instance {
    final dioInstance = Dio(
      BaseOptions(
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 60)),
    );
    dioInstance.interceptors.addAll(
      [
        if (kDebugMode)
          LogInterceptor(
            responseBody: true,
            error: true,
            request: true,
            requestBody: true,
            requestHeader: true,
            responseHeader: true,
          ),
      ],
    );
    fixBadCertificate(dio: dioInstance);
    return dioInstance;
  }

  Future<Either<DevfestException, Response?>> call({
    required String path,
    required RequestMethod method,
    dynamic body = const {},
    Map<String, dynamic> queryParams = const {},
    Options? options,
  }) async {
    return await _instance.call(
      path: path,
      method: method,
      body: body,
      queryParams: queryParams,
      options: options,
    );
  }
}

enum RequestMethod { get, post, put, patch, delete }

extension CallX on Dio {
  Future<Either<DevfestException, Response?>> call({
    required String path,
    required RequestMethod method,
    dynamic body = const {},
    Map<String, dynamic> queryParams = const {},
    Options? options,
  }) async {
    try {
      final response = await switch (method) {
        RequestMethod.get =>
          get(path, queryParameters: queryParams, options: options),
        RequestMethod.post => post(path,
            data: body, queryParameters: queryParams, options: options),
        RequestMethod.put =>
          put(path, queryParameters: queryParams, data: body, options: options),
        RequestMethod.patch => patch(path,
            queryParameters: queryParams, data: body, options: options),
        RequestMethod.delete => delete(path,
            queryParameters: queryParams, data: body, options: options),
      };

      return Right(response);
    } on DioException catch (exception) {
      switch (exception.type) {
        case DioExceptionType.badResponse:
          final error = DevfestException.fromErrorResponse(exception.response!);
          return Left(error);
        case _:
          return Left(ClientException(
            exceptionMessage: exception.message ?? 'An error occurred',
          ));
      }
    } on Exception catch (e) {
      return Left(ClientException(exceptionMessage: e.toString()));
    }
  }
}

///This function used for those devices which doesnot support
/// newer ssl certificate and disabled in web
void fixBadCertificate({required Dio dio}) {
  if (!kIsWeb) {
    dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        // Don't trust any certificate just because their root cert is trusted.
        final HttpClient client =
            HttpClient(context: SecurityContext(withTrustedRoots: false));
        // You can test the intermediate / root cert here. We just ignore it.
        client.badCertificateCallback = (cert, host, port) => true;
        return client;
      },
      validateCertificate: (cert, host, port) => true,
    );
  }
}
