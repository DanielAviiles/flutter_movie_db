
import 'package:flutter_movies_db/app/core/bloc/models/default_validator_model.dart';

mixin MessageValidatorConstant {
  static String msgIsRequired() => 'Este campo es requerido';
  static String msgMaxLength(int maxLenght) =>
      'Debe ser menor a $maxLenght caracteres';
  static String msgMinLength(int minLenght) =>
      'Debe ser mayor a $minLenght caracteres';
  static String msgMin(int min) => 'El valor  no puede ser menor a $min';
  static String msgMax(int max) => 'El valor  no puede ser mayor a $max';
  static String msgValidEmail() =>
      'Debe digitar un email valido ej: example@domain.com';
  static String msgValidEqual() => 'Los valores deben coincidir';
  static String msgOperator(LogicalOperatorValidator validationLogicalOperators,
      List<dynamic> value) {
    return 'El número de registros(${value.length}) debe ser ${validationLogicalOperators.operator.getTextFormat} ${validationLogicalOperators.value}';
  }
}
