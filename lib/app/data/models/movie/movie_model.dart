import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_movies_db/app/core/api/api_route_config.dart';
import 'package:flutter_movies_db/app/core/constant/local_paths_constant.dart';

part 'movie_model.g.dart';

@JsonSerializable()
class MovieModel {
  @JsonKey()
  final bool adult;

  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;

  @JsonKey(name: 'genre_ids')
  final List<int> genreIds;

  @JsonKey()
  final int id;

  @JsonKey(name: 'original_language')
  final String originalLanguage;

  @JsonKey(name: 'original_title')
  final String originalTitle;

  @JsonKey()
  final String overview;

  @JsonKey()
  final double popularity;

  @JsonKey(name: 'poster_path')
  final String? posterPath;

  @JsonKey(name: 'release_date')
  final String? releaseDate;

  @JsonKey()
  final String title;

  @JsonKey()
  final bool video;

  @JsonKey(name: 'vote_average')
  final double voteAverage;

  @JsonKey(name: 'vote_count')
  final int voteCount;

  @JsonKey(ignore: true)
  final String? heroId;

  MovieModel({
    required this.adult,
    this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    this.posterPath,
    this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
    this.heroId,
  });

  MovieModel copyWith({
    bool? adult,
    String? backdropPath,
    List<int>? genreIds,
    int? id,
    String? originalLanguage,
    String? originalTitle,
    String? overview,
    double? popularity,
    String? posterPath,
    String? releaseDate,
    String? title,
    bool? video,
    double? voteAverage,
    int? voteCount,
    String? heroId,
  }) =>
      MovieModel(
        adult: adult ?? this.adult,
        genreIds: genreIds ?? this.genreIds,
        id: id ?? this.id,
        originalLanguage: originalLanguage ?? this.originalLanguage,
        originalTitle: originalTitle ?? this.originalTitle,
        overview: overview ?? this.overview,
        popularity: popularity ?? this.popularity,
        title: title ?? this.title,
        video: video ?? this.video,
        voteAverage: voteAverage ?? this.voteAverage,
        voteCount: voteCount ?? this.voteCount,
        heroId: heroId ?? this.heroId,
        releaseDate: releaseDate ?? this.releaseDate,
        backdropPath: backdropPath ?? this.backdropPath,
        posterPath: posterPath ?? this.posterPath,
      );

  factory MovieModel.fromJson(Map<String, dynamic> json) =>
      _$MovieModelFromJson(json);
  Map<String, dynamic> toJson() => _$MovieModelToJson(this);

  String get fullPosterImg {
    if (posterPath != null) {
      return '${ApiRouteConfig.baseImgUrl}/t/p/w500$posterPath';
    }
    return LocalPaths.placeHolderPosterMovie;
  }

  String get fullBackdropimg {
    if (backdropPath != null) {
      return '${ApiRouteConfig.baseImgUrl}/t/p/w500$backdropPath';
    }
    return LocalPaths.placeHolderPosterMovie;
  }
}
