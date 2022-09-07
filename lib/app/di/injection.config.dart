// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i5;
import 'package:injectable/injectable.dart' as _i2;

import '../core/infrastructure/remote/http/http_datasource_impl.dart' as _i4;
import '../core/infrastructure/remote_datasource.dart' as _i3;
import '../data/remote/cast/cast_repository_remote.dart' as _i7;
import '../data/remote/movie/movie_repository_remote.dart' as _i9;
import '../data/remote/movie/search_movie_repository_remote.dart' as _i10;
import '../modules/details/application/commands/get_cast_movie_remote_usecase.dart'
    as _i14;
import '../modules/details/domain/repository/cast_repository.dart' as _i6;
import '../modules/home/application/commands/get_movies_populars_remote_usecase.dart'
    as _i11;
import '../modules/home/application/commands/get_movies_remote_usecase.dart'
    as _i12;
import '../modules/home/application/commands/get_search_movie_usecase.dart'
    as _i13;
import '../modules/home/domain/repository/movie_repository.dart'
    as _i8; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.RemoteDataSource>(
      () => _i4.HttpDataSourceImpl(get<_i5.Client>()),
      instanceName: 'HTTP_DATASOURCE');
  gh.factory<_i6.GetCastMovieRepository>(() => _i7.CastRepositoryImpl(
      get<_i3.RemoteDataSource>(instanceName: 'HTTP_DATASOURCE')));
  gh.factory<_i8.GetMovieRepository>(() => _i9.MovieRepositoryImpl(
      get<_i3.RemoteDataSource>(instanceName: 'HTTP_DATASOURCE')));
  gh.factory<_i8.GetMovieSearchRepository>(() => _i10.SearchMovieRepositoryImpl(
      get<_i3.RemoteDataSource>(instanceName: 'HTTP_DATASOURCE')));
  gh.factory<_i11.GetMoviesPopularsRemoteUsecase>(
      () => _i11.GetMoviesPopularsRemoteUsecase(get<_i8.GetMovieRepository>()));
  gh.factory<_i12.GetMoviesRemoteUsecase>(
      () => _i12.GetMoviesRemoteUsecase(get<_i8.GetMovieRepository>()));
  gh.factory<_i13.GetSearchMovieRemoteUsecase>(() =>
      _i13.GetSearchMovieRemoteUsecase(get<_i8.GetMovieSearchRepository>()));
  gh.factory<_i14.GetCastMovieRemoteUsecase>(
      () => _i14.GetCastMovieRemoteUsecase(get<_i6.GetCastMovieRepository>()));
  return get;
}
