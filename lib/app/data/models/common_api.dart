
import 'package:json_annotation/json_annotation.dart';

part 'common_api.g.dart';

@JsonSerializable()
class CommonApi {
  CommonApi(
      {this.statusCode, this.detail, this.key, this.message, this.messageKey});
  factory CommonApi.fromJson(Map<String, dynamic> json) =>
      _$CommonApiFromJson(json);
  Map<String, dynamic> toJson() => _$CommonApiToJson(this);
  int? statusCode;
  String? detail;
  String? key;
  String? message;
  @JsonKey(name: 'message_key')
  String? messageKey;
}
