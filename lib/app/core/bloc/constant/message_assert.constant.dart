mixin MessageAssertConstant {
  static String msgAssertOnlyNums(int min,String type) => 'Invalid data type for verification of $type : $min, only types allowed :int, double, num';
  static String msgAssertEmail() => 'Invalid data type for verification of Email : only types allowed :String';
  static String msgAssertNullPropertyConfirmEqual(String property) => 'property "$property" cannot be null';
  static String msgAssertNullPropertyValidateEqualsEqual(String property) => 'property "$property" you must set the value to true';
}