// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:flutter_movies_db/app/core/exceptions/exceptions.dart';
import 'package:flutter_movies_db/app/core/infrastructure/remote_datasource.dart';
import 'package:flutter_movies_db/app/core/infrastructure/remote_datasource_types.dart';
import 'package:flutter_movies_db/app/core/utils/json_utils.dart';
import 'package:flutter_movies_db/app/data/models/response_api.dart';

@Named(RemoteDataSourceTypes.HTTP_DATASOURCE)
@Injectable(as: RemoteDataSource)
class HttpDataSourceImpl implements RemoteDataSource {
  HttpDataSourceImpl(this.client);

  http.Client client;

  ResponseApi responseOk(http.Response response, String url) {
    Map<String, dynamic>? body;
    List<Map<String, dynamic>>? bodyList;
    final String bodyData = utf8.decode(response.bodyBytes);
    if (response.statusCode != 204 && JsonUtils.isValidJson(bodyData)) {
      if (JsonUtils.jsonIsList(bodyData)) {
        bodyList = JsonUtils.convertStringToListMap(bodyData);
      } else {
        body = JsonUtils.convertStringToMap(bodyData);
      }
    }
    final ResponseApi dataResponseApi = ResponseApi(
        code: response.statusCode,
        headers: response.headers,
        bodyBytes: response.bodyBytes,
        message: 'Ok $url',
        bodyList: bodyList,
        body: body,
        data: bodyList ?? body ?? bodyData);
    return dataResponseApi;
  }

  ApiException responseError(http.Response response, String url,
      {String method = ''}) {
    client.close();
    client = http.Client();
    log('Error - $method CODE: ${response.statusCode} - $url: ${response.reasonPhrase}: BODY (${response.body}) ');
    return ApiException(
      message: 'Error - $method $url: ${response.body}',
      code: response.statusCode,
      body: response.body,
      detail: response.reasonPhrase.toString(),
    );
  }

  void logException(dynamic error, StackTrace? stackTrace, String url,
      {String method = '', int? statusCode, required Type type}) {
    client.close();
    client = http.Client();
    log('${type.toString()} - $method  $url: ${error.toString()}');
  }

  @override
  Future<ResponseApi> post(
      {required String enpoint,
      required Map<String, dynamic>? body,
      Map<String, dynamic>? params,
      Map<String, String>? headers,
      int timeOutSec = 30}) async {
    final Map<String, dynamic> queryParams = <String, dynamic>{};
    if (params != null) {
      queryParams.addAll(params);
    }
    final String query = Uri(queryParameters: queryParams).query;
    final String url = Uri.decodeComponent(
        "$enpoint${!<dynamic>[null, ""].contains(query) ? '?$query' : ''}");
    try {
      final String toSend = json.encode(body);
      final http.Response response = await client
          .post(Uri.parse(url), headers: headers, body: toSend)
          .timeout(Duration(seconds: timeOutSec));
      if (response.statusCode >= 200 && response.statusCode <= 204) {
        log('Request - POST  successfuly: $url');
        return responseOk(response, url);
      } else {
        throw responseError(response, url, method: 'POST');
      }
    } on TimeoutException catch (_, stackTrace) {
      logException(_, stackTrace, url,
          method: 'POST', statusCode: 408, type: TimeoutException);
      rethrow;
    } on SocketException catch (_, stackTrace) {
      logException(_, stackTrace, url, method: 'POST', type: SocketException);

      rethrow;
    } catch (_, stackTrace) {
      logException(_, stackTrace, url, method: 'POST', type: Exception);
      rethrow;
    }
  }

  @override
  Future<ResponseApi> put(
      {required String enpoint,
      Map<String, dynamic>? body,
      Map<String, dynamic>? params,
      Map<String, String>? headers,
      int timeOutSec = 30}) async {
    final Map<String, dynamic> queryParams = <String, dynamic>{};
    if (params != null) {
      queryParams.addAll(params);
    }
    final String query = Uri(queryParameters: queryParams).query;
    final String url = Uri.decodeComponent(
        "$enpoint${!<dynamic>[null, ""].contains(query) ? '?$query' : ''}");
    try {
      final String toSend = json.encode(body);
      final http.Response response = await client
          .put(Uri.parse(url), headers: headers, body: toSend)
          .timeout(Duration(seconds: timeOutSec));
      if (response.statusCode >= 200 && response.statusCode <= 204) {
        log('PUT Ok  -> $url');
        return responseOk(response, url);
      } else {
        throw responseError(response, url, method: 'PUT');
      }
    } on TimeoutException catch (_, stackTrace) {
      logException(_, stackTrace, url,
          method: 'PUT', statusCode: 408, type: TimeoutException);
      rethrow;
    } on SocketException catch (_, stackTrace) {
      logException(_, stackTrace, url, method: 'PUT', type: SocketException);
      rethrow;
    } catch (_, stackTrace) {
      logException(_, stackTrace, url, method: 'PUT', type: Exception);
      rethrow;
    }
  }

  @override
  Future<ResponseApi> get(
      {required String enpoint,
      Map<String, dynamic>? params,
      Map<String, String>? headers,
      int timeOutSec = 30}) async {
    final Map<String, dynamic> queryParams = <String, dynamic>{};
    if (params != null) {
      queryParams.addAll(params);
    }
    final String query = Uri(queryParameters: queryParams).query;
    final String url = Uri.decodeComponent(
        "$enpoint${!<dynamic>[null, ""].contains(query) ? '?$query' : ''}");
    try {
      final http.Response response = await client
          .get(Uri.parse(url), headers: headers)
          .timeout(Duration(seconds: timeOutSec));
      if (response.statusCode >= 200 && response.statusCode <= 204) {
        log('Request - GET  successfuly: $url');
        return responseOk(response, url);
      } else {
        throw responseError(response, url, method: 'GET');
      }
    } on TimeoutException catch (_, stackTrace) {
      logException(_, stackTrace, url,
          method: 'GET', statusCode: 408, type: TimeoutException);
      rethrow;
    } on SocketException catch (_, stackTrace) {
      logException(_, stackTrace, url, method: 'GET', type: SocketException);
      rethrow;
    } catch (_, stackTrace) {
      logException(_, stackTrace, url, method: 'GET', type: Exception);
      rethrow;
    }
  }

  @override
  Future<ResponseApi> delete(
      {required String enpoint,
      required dynamic id,
      Map<String, String>? headers,
      int timeOutSec = 30}) async {
    final String url = Uri.decodeComponent('$enpoint/$id');
    try {
      final http.Response response = await client
          .delete(Uri.parse(url), headers: headers)
          .timeout(Duration(seconds: timeOutSec));
      if (response.statusCode >= 200 && response.statusCode <= 204) {
        log('DELETE Ok  -> $url');
        return responseOk(response, url);
      } else {
        throw responseError(response, url, method: 'DELETE');
      }
    } on TimeoutException catch (_, stackTrace) {
      logException(_, stackTrace, url,
          method: 'DELETE', statusCode: 408, type: TimeoutException);
      rethrow;
    } on SocketException catch (_, stackTrace) {
      logException(_, stackTrace, url, method: 'DELETE', type: SocketException);
      rethrow;
    } catch (_, stackTrace) {
      logException(_, stackTrace, url, method: 'DELETE', type: Exception);
      rethrow;
    }
  }

  @override
  Future<ResponseApi> patch(
      {required String enpoint,
      required Map<String, dynamic>? body,
      Map<String, dynamic>? params,
      Map<String, String>? headers,
      int timeOutSec = 30}) async {
    final Map<String, dynamic> queryParams = <String, dynamic>{};
    if (params != null) {
      queryParams.addAll(params);
    }
    final String query = Uri(queryParameters: queryParams).query;
    final String url = Uri.decodeComponent(
        "$enpoint${!<dynamic>[null, ""].contains(query) ? '?$query' : ''}");
    try {
      final String toSend = json.encode(body);
      final http.Response response = await client
          .patch(Uri.parse(url), headers: headers, body: toSend)
          .timeout(Duration(seconds: timeOutSec));
      if (response.statusCode >= 200 && response.statusCode <= 204) {
        log('PATCH Ok  -> $url');
        return responseOk(response, url);
      } else {
        throw responseError(response, url, method: 'PATCH');
      }
    } on TimeoutException catch (_, stackTrace) {
      logException(_, stackTrace, url,
          method: 'PATCH', statusCode: 408, type: TimeoutException);
      rethrow;
    } on SocketException catch (_, stackTrace) {
      logException(_, stackTrace, url, method: 'PATCH', type: SocketException);
      rethrow;
    } catch (_, stackTrace) {
      logException(_, stackTrace, url, method: 'PATCH', type: Exception);
      rethrow;
    }
  }
}
