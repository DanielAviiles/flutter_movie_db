import 'package:dartz/dartz.dart';

class Failure {
  Failure(this.message, {this.key, this.exception});
  final String message;
  String? key;
  Exception? exception;

  @override
  String toString() {
    return message;
  }

  static Left<Failure, T> error<T>(String? key, String? message,
      {Exception? ex}) {
    final Failure failure =
        Failure(message ?? 'Error Desconocido', key: key, exception: ex);
    return Left<Failure, T>(failure);
  }
}
