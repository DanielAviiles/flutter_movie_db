import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_movies_db/app/core/api/api_route_config.dart';
import 'package:flutter_movies_db/app/core/constant/server_constant.dart';
import 'package:flutter_movies_db/app/core/errors/failure.dart';
import 'package:flutter_movies_db/app/core/exceptions/exceptions.dart';
import 'package:flutter_movies_db/app/core/infrastructure/remote_datasource.dart';
import 'package:flutter_movies_db/app/core/infrastructure/remote_datasource_types.dart';
import 'package:flutter_movies_db/app/data/models/movie/movie_model.dart';
import 'package:flutter_movies_db/app/data/models/movie_response_generic/movie_response_generic_model.dart';
import 'package:flutter_movies_db/app/data/models/response_api.dart';
import 'package:flutter_movies_db/app/modules/home/domain/repository/movie_repository.dart';

@Injectable(as: GetMovieSearchRepository)
class SearchMovieRepositoryImpl implements GetMovieSearchRepository {
  SearchMovieRepositoryImpl(
      @Named(RemoteDataSourceTypes.HTTP_DATASOURCE) this._api);

  final RemoteDataSource _api;

  @override
  Future<Either<Failure, List<MovieModel>>>? getSearchMovies(
    String query,
  ) async {
    try {
      final ResponseApi reponseMovies = await _api.get(
          enpoint: '${ApiRouteConfig.baseUrl}/3/search/movie',
          params: {
            'api_key': ApiRouteConfig.apiKey,
            'language': 'es-ES',
            'query': query
          }).timeout(const Duration(seconds: 30));
      if (reponseMovies.code == 200 || reponseMovies.code == 201) {
        final genericReponse =
            MovieResponseGenericModel.fromJson(reponseMovies.body!);
        final List<MovieModel> movies = genericReponse.results;
        return Right<Failure, List<MovieModel>>(movies);
      } else {
        log('Fallo al encontrar peliculas: Status ${reponseMovies.code}');
        return Failure.error(
          ServerConstant.unknowError,
          'Fallo al encontrar peliculas',
        );
      }
    } on TimeoutException catch (_) {
      log(_.toString());
      return Failure.error(ServerConstant.timeOutException, _.message, ex: _);
    } on SocketException catch (_) {
      log(_.toString());
      return Failure.error(ServerConstant.socketException, _.message, ex: _);
    } on ApiException catch (_) {
      log(_.toString());
      return Failure.error(
          _.getErrorApi()?.messageKey, _.getErrorApi()?.message,
          ex: _);
    } catch (e) {
      log('Fallo al Buscar la pelicula: $e');
      return Failure.error(
        ServerConstant.timeOutException,
        'Fallo al Buscar la pelicula ',
      );
    }
  }
}
