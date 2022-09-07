// ignore_for_file: avoid_renaming_method_parameters, non_constant_identifier_names, avoid_types_as_parameter_names

import 'package:dartz/dartz.dart';
import 'package:flutter_movies_db/app/data/models/cast/cast_model.dart';
import 'package:flutter_movies_db/app/modules/details/domain/repository/cast_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_movies_db/app/core/errors/failure.dart';
import 'package:flutter_movies_db/app/core/usecase/command.dart';

@injectable
class GetCastMovieRemoteUsecase
    extends Command<Either<Failure, List<Cast>>, String> {
  GetCastMovieRemoteUsecase(this.getCastMovieRemoteRepository);
  final GetCastMovieRepository getCastMovieRemoteRepository;

  @override
  Future<Either<Failure, List<Cast>>?> execute(String params) async {
    return getCastMovieRemoteRepository.getCastOfMovies(params);
  }
}
