import 'package:dartz/dartz.dart';
import 'package:flutter_movies_db/app/core/errors/failure.dart';
import 'package:flutter_movies_db/app/data/models/movie/movie_model.dart';
import 'package:flutter_movies_db/app/modules/home/domain/models/properties_movie_usecase.dart';

abstract class GetMovieSearchRepository {
  Future<Either<Failure, List<MovieModel>>>? getSearchMovies(String query);
}

abstract class GetMovieRepository {
  Future<Either<Failure, List<MovieModel>>>? getMovies(
      PropertiesMovieUseCase params);
}
