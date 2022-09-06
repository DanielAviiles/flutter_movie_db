import 'package:flutter_movies_db/app/core/errors/failure.dart';
import 'package:flutter_movies_db/app/data/models/movie/movie_model.dart';
import 'package:flutter_movies_db/app/modules/home/ui/bloc/movie_state.dart';

// LIST MOVIES FINDED / SEARCH
// ========================================================
class MovieStateLoadingSearched extends MovieState {
  MovieStateLoadingSearched({this.listMovies, this.listMoviesPopulars})
      : super(
            movies: listMovies,
            moviesPopulars: listMoviesPopulars,
            moviesSearched: []);
  final List<MovieModel>? listMovies;
  final List<MovieModel>? listMoviesPopulars;
}

class MovieStateSearchedError extends MovieState {
  MovieStateSearchedError(
      List<MovieModel>? list, List<MovieModel>? populars, this.failure)
      : super(movies: list, moviesPopulars: populars, moviesSearched: []);
  final Failure failure;
}

class MovieStateSearchedSuccess extends MovieState {
  MovieStateSearchedSuccess({this.listMovies, this.populars, this.searched})
      : super(
            movies: listMovies,
            moviesPopulars: populars,
            moviesSearched: searched);
  final List<MovieModel>? listMovies;
  final List<MovieModel>? populars;
  final List<MovieModel>? searched;
}
// ========================================================