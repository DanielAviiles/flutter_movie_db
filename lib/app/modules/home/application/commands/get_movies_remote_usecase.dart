// ignore_for_file: avoid_renaming_method_parameters, non_constant_identifier_names, avoid_types_as_parameter_names

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_movies_db/app/core/errors/failure.dart';
import 'package:flutter_movies_db/app/core/usecase/command.dart';
import 'package:flutter_movies_db/app/data/models/movie/movie_model.dart';
import 'package:flutter_movies_db/app/modules/home/domain/models/properties_movie_usecase.dart';
import 'package:flutter_movies_db/app/modules/home/domain/repository/movie_repository.dart';

@injectable
class GetMoviesRemoteUsecase
    extends Command<Either<Failure, List<MovieModel>>, PropertiesMovieUseCase> {
  GetMoviesRemoteUsecase(this.getMovieRepository);
  final GetMovieRepository getMovieRepository;

  @override
  Future<Either<Failure, List<MovieModel>>?> execute(
      PropertiesMovieUseCase params) async {
    return getMovieRepository.getMovies(params);
  }
}
