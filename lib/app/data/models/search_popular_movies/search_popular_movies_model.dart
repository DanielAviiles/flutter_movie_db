import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_movies_db/app/data/models/movie/movie_model.dart';

part 'search_popular_movies_model.g.dart';

@JsonSerializable()
class SearchAndPopularMoviesModel {
  @JsonKey()
  final int page;

  @JsonKey()
  final List<MovieModel> results;

  @JsonKey(name: 'total_pages')
  final int totalPages;

  @JsonKey(name: 'total_results')
  final int totalResults;

  SearchAndPopularMoviesModel({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  SearchAndPopularMoviesModel copyWith({
    int? page,
    List<MovieModel>? results,
    int? totalPages,
    int? totalResults,
  }) =>
      SearchAndPopularMoviesModel(
        page: page ?? this.page,
        results: results ?? this.results,
        totalPages: totalPages ?? this.totalPages,
        totalResults: totalResults ?? this.totalResults,
      );

  factory SearchAndPopularMoviesModel.fromJson(Map<String, dynamic> json) =>
      _$SearchAndPopularMoviesModelFromJson(json);
  Map<String, dynamic> toJson() => _$SearchAndPopularMoviesModelToJson(this);
}
