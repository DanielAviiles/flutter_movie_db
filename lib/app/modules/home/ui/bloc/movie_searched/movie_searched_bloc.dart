import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movies_db/app/core/errors/failure.dart';
import 'package:flutter_movies_db/app/data/models/movie/movie_model.dart';
import 'package:flutter_movies_db/app/modules/home/application/commands/get_search_movie_usecase.dart';
import 'package:flutter_movies_db/app/modules/home/ui/bloc/movie_state.dart';
import 'package:flutter_movies_db/helpers/debouncer.dart';

class MovieSearchedBloc extends Cubit<MovieState> {
  MovieSearchedBloc({required this.searchMovieRemoteUsecase})
      : super(MovieStateInit()) {
    init();
  }

  final GetSearchMovieRemoteUsecase searchMovieRemoteUsecase;

  final Debouncer<String> debouncer = Debouncer<String>(
    duration: const Duration(milliseconds: 500),
  );

  void init() {}

  Future<void> findingMovie(String title) async {
    emit(state.setMovieStateSearchedLoading());
    final Either<Failure, List<MovieModel>>? response =
        await searchMovieRemoteUsecase.execute(title);
    response?.fold((failure) {
      emit(state.setMovieStateSearchedError(failure));
    }, (value) {
      emit(state.setMovieStateSearchedSuccess(value));
    });
  }

  void getSuggestionByQuery(String searchTerm) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      await findingMovie(value);
      // _suggestionStreamController.add(result);
    };
    final timer = Timer.periodic(const Duration(milliseconds: 300), (_) {
      debouncer.value = searchTerm;
    });
    Future.delayed(const Duration(milliseconds: 301))
        .then((_) => timer.cancel());
  }
}
