import 'package:json_annotation/json_annotation.dart';

part 'dates_model.g.dart';

@JsonSerializable()
class DatesModel {
  @JsonKey()
  final DateTime maximum;

  @JsonKey()
  final DateTime minimum;

  DatesModel({required this.maximum, required this.minimum});

  DatesModel copyWith({
    DateTime? maximum,
    DateTime? minimum,
  }) =>
      DatesModel(
        maximum: maximum ?? this.maximum,
        minimum: minimum ?? this.minimum,
      );

  factory DatesModel.fromJson(Map<String, dynamic> json) =>
      _$DatesModelFromJson(json);
  Map<String, dynamic> toJson() => _$DatesModelToJson(this);
}
