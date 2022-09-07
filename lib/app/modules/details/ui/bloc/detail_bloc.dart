import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movies_db/app/core/errors/failure.dart';
import 'package:flutter_movies_db/app/data/models/cast/cast_model.dart';
import 'package:flutter_movies_db/app/modules/details/application/commands/get_cast_movie_remote_usecase.dart';
import 'package:flutter_movies_db/app/modules/details/ui/bloc/detail_state.dart';

class DetailMovieBloc extends Cubit<CastState> {
  DetailMovieBloc({required this.castMovieRemoteUseCase})
      : super(CastStateInit());

  final GetCastMovieRemoteUsecase castMovieRemoteUseCase;

  void getMovieCast(String movieId) async {
    CastStateLoading();
    final Either<Failure, List<Cast>>? response =
        await castMovieRemoteUseCase.execute(movieId);
    response?.fold((failure) {
      emit(CastStateError());
    }, (value) {
      emit(CastStateSuccess(listCast: value));
    });
  }
}
