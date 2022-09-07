import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_movies_db/app/data/models/actors/actors_model.dart';
import 'package:flutter_movies_db/app/data/models/cast/cast_model.dart';
import 'package:flutter_movies_db/app/modules/details/domain/repository/cast_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_movies_db/app/core/api/api_route_config.dart';
import 'package:flutter_movies_db/app/core/constant/server_constant.dart';
import 'package:flutter_movies_db/app/core/errors/failure.dart';
import 'package:flutter_movies_db/app/core/exceptions/exceptions.dart';
import 'package:flutter_movies_db/app/core/infrastructure/remote_datasource.dart';
import 'package:flutter_movies_db/app/core/infrastructure/remote_datasource_types.dart';
import 'package:flutter_movies_db/app/data/models/response_api.dart';

@Injectable(as: GetCastMovieRepository)
class CastRepositoryImpl implements GetCastMovieRepository {
  CastRepositoryImpl(@Named(RemoteDataSourceTypes.HTTP_DATASOURCE) this._api);

  final RemoteDataSource _api;

  @override
  Future<Either<Failure, List<Cast>>>? getCastOfMovies(String movieId) async {
    try {
      final ResponseApi reponseMovies = await _api.get(
        enpoint: '${ApiRouteConfig.baseUrl}/3/movie/$movieId/credits',
        params: {
          'api_key': ApiRouteConfig.apiKey,
          'language': ApiRouteConfig.language
        },
      ).timeout(const Duration(seconds: 30));
      if (reponseMovies.code == 200 || reponseMovies.code == 201) {
        final genericReponse = ActorsModel.fromJson(reponseMovies.body!);
        final List<Cast> cast = genericReponse.cast;
        return Right<Failure, List<Cast>>(cast);
      } else {
        log('Fallo al encontrar el reparto: Status ${reponseMovies.code}');
        return Failure.error(
          ServerConstant.unknowError,
          'Fallo al encontrar casting',
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
      log('Fallo al encontrar casting :( $e');
      return Failure.error(
        ServerConstant.timeOutException,
        'Fallo al encontrar casting',
      );
    }
  }
}
