import 'dart:typed_data';
import 'package:flutter_movies_db/app/data/models/response_global.dart';

class ResponseApi extends ResponseGlobal<dynamic> {
  ResponseApi({
    String? message,
    dynamic data,
    this.headers,
    this.code = 0,
    this.bodyBytes,
    this.body,
    this.bodyList,
  }) : super(isSuccess: true, message: message, data: data);
  Uint8List? bodyBytes;
  Map<String, String>? headers;
  Map<String, dynamic>? body;
  List<Map<String, dynamic>>? bodyList;
  int code;

  ResponseApi copyWith(
          {String? message,
          Uint8List? bodyBytes,
          Map<String, String>? headers,
          int? code,
          dynamic data,
          String? bodyString,
          Map<String, dynamic>? body,
          List<Map<String, dynamic>>? bodyList}) =>
      ResponseApi(
          body: body ?? this.body,
          bodyList: bodyList ?? this.bodyList,
          message: message ?? this.message,
          headers: headers ?? this.headers,
          code: code ?? this.code,
          bodyBytes: bodyBytes ?? this.bodyBytes,
          data: data ?? this.data);
}
