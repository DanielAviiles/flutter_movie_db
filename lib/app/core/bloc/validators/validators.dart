import 'package:flutter_movies_db/app/core/bloc/constant/message_validator.constant.dart';
import 'package:flutter_movies_db/app/core/bloc/models/default_validator_model.dart';
import 'package:flutter_movies_db/app/core/bloc/models/logical_operator_model.dart';
import 'package:flutter_movies_db/app/core/utils/functions_utils.dart';

mixin Validators {
  static String? hasErrorDefaultValidators(
      DefaultValidators? defaultValidators, dynamic value, Type type) {
    if (defaultValidators != null) {
      if (defaultValidators.required && !isValidateRequired(value)) {
        return MessageValidatorConstant.msgIsRequired();
      } else if (defaultValidators.maxLength is int &&
          !isValidateMaxLength(defaultValidators.maxLength!, value)) {
        return MessageValidatorConstant.msgMaxLength(
            defaultValidators.maxLength!);
      } else if (defaultValidators.minLength is int &&
          !isValidateMinLength(defaultValidators.minLength!, value)) {
        return MessageValidatorConstant.msgMinLength(
            defaultValidators.minLength!);
      } else if (defaultValidators.min is int &&
          (type == int || type == double || type == num) &&
          !isValidateMin(defaultValidators.min!, value, type)) {
        return MessageValidatorConstant.msgMin(defaultValidators.min!);
      } else if (defaultValidators.max is int &&
          (type == int || type == double || type == num) &&
          !isValidateMax(defaultValidators.max!, value, type)) {
        return MessageValidatorConstant.msgMax(defaultValidators.max!);
      } else if (defaultValidators.validEmail == true &&
          !isValidateEmail(value)) {
        return MessageValidatorConstant.msgValidEmail();
      } //Only List
      else if (defaultValidators.logicalOperatorValidator != null &&
          !isValidateWithLogicalOperators(
              defaultValidators.logicalOperatorValidator!, value)) {
        return MessageValidatorConstant.msgOperator(
            defaultValidators.logicalOperatorValidator!,
            value as List<dynamic>);
      } else if (defaultValidators.regularExpressionValidator != null &&
          defaultValidators.regularExpressionValidator!.isNotEmpty) {
        for (final RegularExpressionValidator item
            in defaultValidators.regularExpressionValidator!) {
          if (!isValidRegExp(item.regExp, value)) {
            return item.messageError;
          }
        }
      } else {
        return null;
      }
    } else {
      return null;
    }
    return null;
  }

  ///<Methods for validate>
  ///========================================================================================================
  ///========================================================================================================
  static bool isValidateRequired(dynamic value) {
    // ignore: prefer_single_quotes
    if (<dynamic>[null, 'undefined', '', ""].contains(value) ||
        (value is List && value.isEmpty)) {
      return false;
    }
    return true;
  }

  static bool isValidateMaxLength(int maxLength, dynamic value) {
    final String checkValue = value == null ? '' : value.toString();
    if (checkValue.length > maxLength && checkValue.isNotEmpty) {
      return false;
    }
    return true;
  }

  static bool isValidateMinLength(int minLength, dynamic value) {
    final String checkValue = value == null ? '' : value.toString();
    if (checkValue.length < minLength && checkValue.isNotEmpty) {
      return false;
    }
    return true;
  }

  static bool isValidateMin(int min, dynamic value, Type type) {
    if ((type == int &&
            isNumeric(value) &&
            int.parse(value.toString()) < min) ||
        (type == double &&
            isNumeric(value) &&
            double.parse(value.toString()) < min) ||
        (type == num &&
            isNumeric(value) &&
            num.parse(value.toString()) < min)) {
      return false;
    }
    return true;
  }

  static bool isValidateMax(int max, dynamic value, Type type) {
    if ((type == int &&
            isNumeric(value) &&
            int.parse(value.toString()) > max) ||
        (type == double &&
            isNumeric(value) &&
            double.parse(value.toString()) > max) ||
        (type == num &&
            isNumeric(value) &&
            num.parse(value.toString()) > max)) {
      return false;
    }

    return true;
  }

  static bool isValidateEmail(dynamic value) {
    const String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    final RegExp regExp = RegExp(pattern);
    final String checkValue = value == null ? '' : value.toString();
    if (regExp.hasMatch(checkValue)) {
      return true;
    } else {
      return false;
    }
  }

  static bool isValidRegExp(RegExp regExp, dynamic value) {
    final String checkValue = value == null ? '' : value.toString();
    if (regExp.hasMatch(checkValue)) {
      return true;
    } else {
      return false;
    }
  }

  static bool isValidateWithLogicalOperators(
      LogicalOperatorValidator validationLogicalOperators, dynamic value) {
    bool isValid = false;
    if (value is List) {
      final Map<LogicalOperators, bool> evalueted = <LogicalOperators, bool>{
        LogicalOperators.equal:
            value.length == validationLogicalOperators.value,
        LogicalOperators.greaterThan:
            value.length > validationLogicalOperators.value,
        LogicalOperators.lessThan:
            value.length < validationLogicalOperators.value,
        LogicalOperators.lessThanOrEqual:
            value.length <= validationLogicalOperators.value,
        LogicalOperators.greaterThanOrEqual:
            value.length <= validationLogicalOperators.value,
      };
      isValid = evalueted[validationLogicalOperators.operator] ?? true;
    } else {
      isValid = true;
    }
    return isValid;
  }
  ////</Methods for validate>
  ///========================================================================================================
  ///========================================================================================================
}
