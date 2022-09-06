
import 'logical_operator_model.dart';

class DefaultValidators {
  DefaultValidators(
      {this.required = false,
      this.maxLength,
      this.minLength,
      this.min,
      this.max,
      this.validEmail = false,
      this.logicalOperatorValidator,
      this.regularExpressionValidator});
  bool required;
  int? maxLength;
  int? minLength;
  int? min;
  int? max;
  bool validEmail;

  /// Only applies to lists
  /// For examples: List<int>, List<String>, etc...
  LogicalOperatorValidator? logicalOperatorValidator;
  List<RegularExpressionValidator>? regularExpressionValidator;

  String getFormatOperatorLabel(int value, String label) {
    if (logicalOperatorValidator != null) {
      return '($value ${logicalOperatorValidator!.operator.value} ${logicalOperatorValidator!.value} $label)';
    }
    return '';
  }
}

class LogicalOperatorValidator {
  LogicalOperatorValidator(this.operator, this.value);
  LogicalOperators operator;
  int value;
}

class RegularExpressionValidator {
  RegularExpressionValidator(this.regExp, {required this.messageError});
  RegExp regExp;
  String messageError;
}
