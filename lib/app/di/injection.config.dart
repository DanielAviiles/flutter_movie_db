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
import '../data/remote/movie/movie_repository_remote.dart' as _i7;
import '../data/remote/movie/search_movie_repository_remote.dart' as _i8;
import '../modules/home/application/commands/get_movies_populars_remote_usecase.dart'
    as _i9;
import '../modules/home/application/commands/get_movies_remote_usecase.dart'
    as _i10;
import '../modules/home/application/commands/get_search_movie_usecase.dart'
    as _i11;
import '../modules/home/domain/repository/movie_repository.dart'
    as _i6; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.RemoteDataSource>(
      () => _i4.HttpDataSourceImpl(get<_i5.Client>()),
      instanceName: 'HTTP_DATASOURCE');
  gh.factory<_i6.GetMovieRepository>(() => _i7.MovieRepositoryImpl(
      get<_i3.RemoteDataSource>(instanceName: 'HTTP_DATASOURCE')));
  gh.factory<_i6.GetMovieSearchRepository>(() => _i8.SearchMovieRepositoryImpl(
      get<_i3.RemoteDataSource>(instanceName: 'HTTP_DATASOURCE')));
  gh.factory<_i9.GetMoviesPopularsRemoteUsecase>(
      () => _i9.GetMoviesPopularsRemoteUsecase(get<_i6.GetMovieRepository>()));
  gh.factory<_i10.GetMoviesRemoteUsecase>(
      () => _i10.GetMoviesRemoteUsecase(get<_i6.GetMovieRepository>()));
  gh.factory<_i11.GetSearchMovieRemoteUsecase>(() =>
      _i11.GetSearchMovieRemoteUsecase(get<_i6.GetMovieSearchRepository>()));
  return get;
}
