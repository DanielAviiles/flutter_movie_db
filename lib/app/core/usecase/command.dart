import 'package:flutter_movies_db/app/core/usecase/usecase.dart';

abstract class Command<Type, Params> extends UseCase<Type, Params> {
  bool readonly = false;
}
