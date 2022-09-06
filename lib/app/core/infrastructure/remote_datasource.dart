import 'package:flutter_movies_db/app/data/models/response_api.dart';

abstract class RemoteDataSource {
  Future<ResponseApi> get(
      {required String enpoint,
      Map<String, dynamic>? params,
      Map<String, String>? headers,
      int timeOutSec = 30});
  Future<ResponseApi> post(
      {required String enpoint,
      required Map<String, dynamic>? body,
      Map<String, dynamic>? params,
      Map<String, String>? headers,
      int timeOutSec = 30});
  Future<ResponseApi> put(
      {required String enpoint,
      required Map<String, dynamic>? body,
      Map<String, dynamic>? params,
      Map<String, String>? headers});
  Future<ResponseApi> patch(
      {required String enpoint,
      required Map<String, dynamic>? body,
      Map<String, dynamic>? params,
      Map<String, String>? headers,
      int timeOutSec = 30});
  Future<ResponseApi> delete(
      {required String enpoint,
      required dynamic id,
      Map<String, String>? headers,
      int timeOutSec = 30});
}
