import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_movies_db/app/data/models/cast/cast_model.dart';

part 'actors_model.g.dart';

@JsonSerializable()
class ActorsModel {
  @JsonKey()
  final int id;

  @JsonKey(defaultValue: <Cast>[])
  final List<Cast> cast;

  ActorsModel({
    required this.id,
    required this.cast,
  });

  ActorsModel copyWith({int? id, List<Cast>? cast}) => ActorsModel(
        id: id ?? this.id,
        cast: cast ?? this.cast,
      );

  Map<String, dynamic> toJson() => _$ActorsModelToJson(this);

  factory ActorsModel.fromJson(Map<String, dynamic> json) =>
      _$ActorsModelFromJson(json);
}
