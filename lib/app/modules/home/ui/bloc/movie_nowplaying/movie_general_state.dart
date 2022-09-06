import 'package:flutter_movies_db/app/core/errors/failure.dart';
import 'package:flutter_movies_db/app/data/models/movie/movie_model.dart';
import 'package:flutter_movies_db/app/modules/home/ui/bloc/movie_state.dart';

// NORMAL MOVIES - LIST MOVIES
// ========================================================
class MovieStateGeneralSucces extends MovieState {
  MovieStateGeneralSucces(
      {this.listMovies, this.listMoviesPopulars, this.searched})
      : super(movies: listMovies, moviesPopulars: listMoviesPopulars);
  final List<MovieModel>? listMovies;
  final List<MovieModel>? listMoviesPopulars;
  final List<MovieModel>? searched;
}

class MovieStateGeneralError extends MovieState {
  MovieStateGeneralError(this.failure, this.listMoviesPopulars, this.searched)
      : super(
            movies: [],
            moviesPopulars: listMoviesPopulars,
            moviesSearched: searched);
  final Failure failure;
  final List<MovieModel>? listMoviesPopulars;
  final List<MovieModel>? searched;
}

class MovieStateGeneralLoading extends MovieState {
  MovieStateGeneralLoading({this.listMovies, this.listMoviesPopulars})
      : super(movies: listMovies, moviesPopulars: listMoviesPopulars);
  final List<MovieModel>? listMovies;
  final List<MovieModel>? listMoviesPopulars;
}
// ========================================================
