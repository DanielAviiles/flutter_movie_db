import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movies_db/app/core/errors/failure.dart';
import 'package:flutter_movies_db/app/data/models/movie/movie_model.dart';
import 'package:flutter_movies_db/app/modules/home/application/commands/get_movies_populars_remote_usecase.dart';
import 'package:flutter_movies_db/app/modules/home/domain/models/properties_movie_usecase.dart';
import 'package:flutter_movies_db/app/modules/home/ui/bloc/movie_state.dart';

class MoviePopularBloc extends Cubit<MovieState> {
  MoviePopularBloc({required this.moviesPopularsRemoteUsecase})
      : super(MovieStateInit()) {
    init();
  }

  final GetMoviesPopularsRemoteUsecase moviesPopularsRemoteUsecase;

  int _popularPage = 0;

  void init() {
    getPopularMovies();
  }

  void getPopularMovies() async {
    _popularPage++;
    final properties =
        PropertiesMovieUseCase(endPoint: '3/movie/popular', page: _popularPage);
    final Either<Failure, List<MovieModel>>? response =
        await moviesPopularsRemoteUsecase.execute(properties);

    response?.fold((failure) {
      emit(state.setMovieStatePopularsError(failure));
    }, (value) {
      emit(state.setMovieStatePopulars(value));
    });
  }
}
