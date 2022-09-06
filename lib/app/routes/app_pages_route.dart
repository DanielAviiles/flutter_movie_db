import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movies_db/app/di/injection.dart';
import 'package:flutter_movies_db/app/modules/details/ui/detail_page.dart';
import 'package:flutter_movies_db/app/modules/home/application/commands/get_movies_populars_remote_usecase.dart';
import 'package:flutter_movies_db/app/modules/home/application/commands/get_movies_remote_usecase.dart';
import 'package:flutter_movies_db/app/modules/home/application/commands/get_search_movie_usecase.dart';
import 'package:flutter_movies_db/app/modules/home/ui/bloc/movie_nowplaying/movie_nowplaying_bloc.dart';
import 'package:flutter_movies_db/app/modules/home/ui/bloc/movie_popular/movie_popular_bloc.dart';
import 'package:flutter_movies_db/app/modules/home/ui/bloc/movie_searched/movie_searched_bloc.dart';
import 'package:flutter_movies_db/app/modules/home/ui/home_page.dart';
import 'package:flutter_movies_db/app/routes/app_routes.dart';

mixin AppPagesRoute {
  static Map<String, Widget Function(BuildContext)> getRoutes() {
    return <String, Widget Function(BuildContext)>{
      AppRoutes.home: (BuildContext context) => MultiBlocProvider(
            providers: [
              BlocProvider<MovieNowPLayingBloc>(
                child: const HomePage(),
                create: (context) => MovieNowPLayingBloc(
                  moviesRemoteUseCase: getItApp<GetMoviesRemoteUsecase>(),
                ),
              ),
              BlocProvider<MoviePopularBloc>(
                child: const HomePage(),
                create: (context) => MoviePopularBloc(
                  moviesPopularsRemoteUsecase:
                      getItApp<GetMoviesPopularsRemoteUsecase>(),
                ),
              ),
              BlocProvider<MovieSearchedBloc>(
                child: const HomePage(),
                create: (context) => MovieSearchedBloc(
                  searchMovieRemoteUsecase:
                      getItApp<GetSearchMovieRemoteUsecase>(),
                ),
              )
            ],
            child: const HomePage(),
          ),
      AppRoutes.details: (BuildContext context) => const DetailPage(),
    };
  }

  static BlocProvider<T> getInstanceBloc<T extends BlocBase<dynamic>>(
      BuildContext context,
      {Widget? widget}) {
    return BlocProvider<T>.value(
      value: BlocProvider.of<T>(context),
      child: widget,
    );
  }

  static void navigateWithBloc<T extends BlocBase<dynamic>>(
      BuildContext context, Widget widget) {
    Navigator.push<T>(
      context,
      MaterialPageRoute<T>(
        builder: (BuildContext contextBuild) {
          return getInstanceBloc<T>(context, widget: widget);
        },
      ),
    );
  }

  static void navigateAndReplaceWithBloc<T extends BlocBase<dynamic>>(
      BuildContext context, Widget widget) {
    Navigator.pushReplacement<void, void>(
      context,
      MaterialPageRoute<T>(
        builder: (BuildContext contextBuild) {
          return getInstanceBloc<T>(context, widget: widget);
        },
      ),
    );
  }

  static void navigateMultiBloc(BuildContext context, Widget widget,
      List<BlocProvider<dynamic>> blocProviderList) {
    Navigator.push<MultiBlocProvider>(
      context,
      MaterialPageRoute<MultiBlocProvider>(
        builder: (BuildContext contextBuild) {
          return MultiBlocProvider(
            providers: blocProviderList,
            child: widget,
          );
        },
      ),
    );
  }
}
