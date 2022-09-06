import 'package:flutter_movies_db/app/core/errors/failure.dart';
import 'package:flutter_movies_db/app/data/models/movie/movie_model.dart';
import 'package:flutter_movies_db/app/modules/home/ui/bloc/movie_nowplaying/movie_general_state.dart';
import 'package:flutter_movies_db/app/modules/home/ui/bloc/movie_popular/movie_populars_state.dart';
import 'package:flutter_movies_db/app/modules/home/ui/bloc/movie_searched/movie_searched.dart';

class MovieState {
  MovieState({this.movies, this.moviesPopulars, this.moviesSearched});

  final List<MovieModel>? movies;
  final List<MovieModel>? moviesPopulars;
  final List<MovieModel>? moviesSearched;

  // ===========================================================================
  // CHANGES STATES MOVIES GENERAL
  MovieState setMovieStateGeneral(List<MovieModel>? listMovies) =>
      MovieStateGeneralSucces(
          listMovies: listMovies,
          listMoviesPopulars: moviesPopulars,
          searched: moviesSearched);
  MovieState setMovieStateGeneralError(Failure failure) =>
      MovieStateGeneralError(failure, moviesPopulars, moviesSearched);
  // ===========================================================================

  // ===========================================================================
  // CHANGES STATES POPULARS
  MovieState setMovieStatePopulars(List<MovieModel>? listPopulars) =>
      MovieStatePopularsSuccess(listMovies: movies, populars: listPopulars);

  MovieState setMovieStatePopularsError(Failure failure) =>
      MovieStatePopularError(failure, movies, moviesSearched);
  // ===========================================================================

  // ===========================================================================
  // CHANGES STATES SEARCHED
  MovieState setMovieStateSearchedSuccess(List<MovieModel>? finded) =>
      MovieStateSearchedSuccess(
          listMovies: movies, populars: moviesPopulars, searched: finded);

  MovieState setMovieStateSearchedError(Failure failure) =>
      MovieStateSearchedError(movies, moviesPopulars, failure);

  MovieState setMovieStateSearchedLoading() => MovieStateLoadingSearched(
      listMovies: movies, listMoviesPopulars: moviesPopulars);
  // ===========================================================================
}

class MovieStateInit extends MovieState {
  MovieStateInit() : super(movies: [], moviesPopulars: [], moviesSearched: []);
}
