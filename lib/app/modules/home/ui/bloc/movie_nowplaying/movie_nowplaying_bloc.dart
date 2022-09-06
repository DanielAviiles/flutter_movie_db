import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movies_db/app/core/errors/failure.dart';
import 'package:flutter_movies_db/app/data/models/movie/movie_model.dart';
import 'package:flutter_movies_db/app/modules/home/application/commands/get_movies_remote_usecase.dart';
import 'package:flutter_movies_db/app/modules/home/domain/models/properties_movie_usecase.dart';
import 'package:flutter_movies_db/app/modules/home/ui/bloc/movie_state.dart';

class MovieNowPLayingBloc extends Cubit<MovieState> {
  MovieNowPLayingBloc({required this.moviesRemoteUseCase})
      : super(MovieStateInit()) {
    init();
  }

  final GetMoviesRemoteUsecase moviesRemoteUseCase;

  void init() {
    getOnDisplayMovies();
  }

  void getOnDisplayMovies() async {
    final properties = PropertiesMovieUseCase(endPoint: '3/movie/now_playing');
    final Either<Failure, List<MovieModel>>? response =
        await moviesRemoteUseCase.execute(properties);

    response?.fold((failure) {
      emit(state.setMovieStateGeneralError(failure));
    }, (value) {
      emit(state.setMovieStateGeneral(value));
    });
  }
}
