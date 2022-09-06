import 'package:flutter_movies_db/app/core/errors/failure.dart';
import 'package:flutter_movies_db/app/data/models/movie/movie_model.dart';
import 'package:flutter_movies_db/app/modules/home/ui/bloc/movie_state.dart';

// LIST MOVIES POPULARS
// ========================================================
class MovieStatePopularError extends MovieState {
  MovieStatePopularError(
      this.failure, List<MovieModel>? list, List<MovieModel>? searched)
      : super(movies: list, moviesPopulars: [], moviesSearched: searched);
  final Failure failure;
}

class MovieStatePopularsSuccess extends MovieState {
  MovieStatePopularsSuccess({this.listMovies, this.populars})
      : super(movies: listMovies, moviesPopulars: populars);
  final List<MovieModel>? listMovies;
  final List<MovieModel>? populars;
}
// ========================================================