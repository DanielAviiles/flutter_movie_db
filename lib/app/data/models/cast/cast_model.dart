import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_movies_db/app/core/api/api_route_config.dart';
import 'package:flutter_movies_db/app/core/constant/local_paths_constant.dart';

part 'cast_model.g.dart';

@JsonSerializable()
class Cast {
  @JsonKey()
  final String name;

  @JsonKey(name: 'original_name')
  final String originalName;

  @JsonKey(name: 'profile_path')
  final String? profilePath;

  Cast({required this.name, required this.originalName, this.profilePath});

  Cast copyWith({String? name, String? originalName, String? profilePath}) =>
      Cast(
        name: name ?? this.name,
        originalName: originalName ?? this.originalName,
        profilePath: profilePath ?? this.profilePath,
      );

  factory Cast.fromJson(Map<String, dynamic> json) => _$CastFromJson(json);

  Map<String, dynamic> toJson() => _$CastToJson(this);

  String get fullActorImg {
    if (profilePath != null) {
      return '${ApiRouteConfig.baseImgUrl}/t/p/w500$profilePath';
    }
    return LocalPaths.placeHolderCast;
  }
}
