import 'package:flutter_movies_db/app/core/usecase/usecase.dart';

abstract class Query<Type, Params> extends UseCase<Type, Params> {
  bool readonly = true;
}

class NoParams {
  List<Object> get props => [];
}
