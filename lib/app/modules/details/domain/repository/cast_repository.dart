import 'package:dartz/dartz.dart';
import 'package:flutter_movies_db/app/core/errors/failure.dart';
import 'package:flutter_movies_db/app/data/models/cast/cast_model.dart';

abstract class GetCastMovieRepository {
  Future<Either<Failure, List<Cast>>>? getCastOfMovies(String params);
}
