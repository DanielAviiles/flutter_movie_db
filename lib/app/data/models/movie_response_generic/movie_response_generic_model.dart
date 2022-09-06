import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_movies_db/app/data/models/dates/dates_model.dart';
import 'package:flutter_movies_db/app/data/models/movie/movie_model.dart';

part 'movie_response_generic_model.g.dart';

@JsonSerializable()
class MovieResponseGenericModel {
  @JsonKey()
  final DatesModel? dates;

  @JsonKey()
  final int page;

  @JsonKey()
  final List<MovieModel> results;

  @JsonKey(name: 'total_pages')
  final int totalPages;

  @JsonKey(name: 'total_results')
  final int totalResults;

  MovieResponseGenericModel({
    this.dates,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  MovieResponseGenericModel copyWith({
    DatesModel? dates,
    int? page,
    List<MovieModel>? results,
    int? totalPages,
    int? totalResults,
  }) =>
      MovieResponseGenericModel(
        dates: dates ?? this.dates,
        page: page ?? this.page,
        results: results ?? this.results,
        totalPages: totalPages ?? this.totalPages,
        totalResults: totalResults ?? this.totalResults,
      );

  factory MovieResponseGenericModel.fromJson(Map<String, dynamic> json) =>
      _$MovieResponseGenericModelFromJson(json);

  Map<String, dynamic> toJson() => _$MovieResponseGenericModelToJson(this);
}
