
class LogicalOperators {
  const LogicalOperators(this.value);
  final String value;

  String get  getTextFormat {
    String findDescOperator ='';
    switch (value) {
      case GREATERTHAN:
      findDescOperator= 'mayor a';
        break;
      case LESSTHAN:
      findDescOperator= 'menor a';
        break;
      case GREATERTHAN_OR_EQUAL:
      findDescOperator= 'mayor/igual a';
        break;
      case LESSTHAN_OR_EQUAL:
      findDescOperator= 'menor/igual a';
        break;
      case EQUAL:
      findDescOperator= 'igual a';
        break;
      default:
    }
    return findDescOperator;
  }

  static const LogicalOperators equal = LogicalOperators(EQUAL);
  static const LogicalOperators greaterThan = LogicalOperators(GREATERTHAN);
  static const LogicalOperators lessThan = LogicalOperators(LESSTHAN);
  static const LogicalOperators greaterThanOrEqual = LogicalOperators(GREATERTHAN_OR_EQUAL);
  static const LogicalOperators lessThanOrEqual = LogicalOperators(LESSTHAN_OR_EQUAL);

  static const String GREATERTHAN='>';
  static const String EQUAL='=';
  static const String LESSTHAN='<';
  static const String GREATERTHAN_OR_EQUAL='>=';
  static const String LESSTHAN_OR_EQUAL='<=';

  /// property [operator] contains values support (>,<,>=,<=,=)
  /// if the property value does not match any supported operator it returns a null value
  static LogicalOperators? findOperatorFromString(String operator){
    LogicalOperators? findOperator;
    switch (operator) {
      case GREATERTHAN:
      findOperator= LogicalOperators.greaterThan;
        break;
      case LESSTHAN:
      findOperator= LogicalOperators.lessThan;
        break;
      case GREATERTHAN_OR_EQUAL:
      findOperator= LogicalOperators.greaterThanOrEqual;
        break;
      case LESSTHAN_OR_EQUAL:
      findOperator= LogicalOperators.lessThanOrEqual;
        break;
      case EQUAL:
      findOperator= LogicalOperators.equal;
        break;
      default:
    }
    return findOperator;
  }
}