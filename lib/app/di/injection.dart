// ignore_for_file: depend_on_referenced_packages

import 'package:flutter_movies_db/app/modules/home/ui/bloc/movie_nowplaying/movie_nowplaying_bloc.dart';
import 'package:flutter_movies_db/app/modules/home/ui/bloc/movie_popular/movie_popular_bloc.dart';
import 'package:flutter_movies_db/app/modules/home/ui/bloc/movie_searched/movie_searched_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as client;
import 'package:injectable/injectable.dart';
import 'package:flutter_movies_db/app/modules/home/application/commands/get_movies_populars_remote_usecase.dart';
import 'package:flutter_movies_db/app/modules/home/application/commands/get_movies_remote_usecase.dart';
import 'package:flutter_movies_db/app/modules/home/application/commands/get_search_movie_usecase.dart';
import 'package:flutter_movies_db/app/modules/home/domain/repository/movie_repository.dart';
import 'injection.config.dart';

final GetIt getItApp = GetIt.instance;

@injectableInit
void configureAppInjection() {
  unregisterServices();
  registerCustoms();
  $initGetIt(getItApp);
}

void registerCustoms() {
  getItApp.registerLazySingleton(() => client.Client());
  getItApp.registerLazySingleton(
      () => MoviePopularBloc(moviesPopularsRemoteUsecase: getItApp()));
  getItApp.registerLazySingleton(
      () => MovieNowPLayingBloc(moviesRemoteUseCase: getItApp()));
  getItApp.registerLazySingleton(
      () => MovieSearchedBloc(searchMovieRemoteUsecase: getItApp()));
}

void unregisterServices() {
  // REPOSITORY
  removeRegistrationIfExists<GetMovieRepository>();
  removeRegistrationIfExists<GetMovieSearchRepository>();

  // USESCASES
  removeRegistrationIfExists<GetMoviesPopularsRemoteUsecase>();
  removeRegistrationIfExists<GetSearchMovieRemoteUsecase>();
  removeRegistrationIfExists<GetMoviesRemoteUsecase>();
}

void removeRegistrationIfExists<T extends Object>({String? instanceName}) {
  if (getItApp.isRegistered<T>(instanceName: instanceName)) {
    getItApp.unregister<T>(instanceName: instanceName);
  }
}
