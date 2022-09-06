import 'package:json_annotation/json_annotation.dart';

import 'common_api.dart';

part 'error_api.g.dart';

@JsonSerializable()
class ErrorApi extends CommonApi {
  ErrorApi(
      {int? statusCode,
      String? detail,
      String? key,
      String? message,
      String? messageKey,
      this.stackTrace})
      : super(
            statusCode: statusCode,
            detail: detail,
            key: key,
            message: message,
            messageKey: messageKey);
  factory ErrorApi.fromJson(Map<String, dynamic> json) =>
      _$ErrorApiFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ErrorApiToJson(this);
  String? stackTrace;
}
