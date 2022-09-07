import 'package:flutter_movies_db/app/data/models/cast/cast_model.dart';

class CastState {
  CastState({this.casting});
  final List<Cast>? casting;
}

class CastStateInit extends CastState {
  CastStateInit() : super(casting: []);
}

class CastStateLoading extends CastState {
  CastStateLoading() : super(casting: []);
}

class CastStateError extends CastState {
  CastStateError() : super(casting: []);
}

class CastStateSuccess extends CastState {
  CastStateSuccess({required this.listCast}) : super(casting: listCast);
  final List<Cast> listCast;
}
