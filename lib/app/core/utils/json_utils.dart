import 'dart:convert' as json;
import 'dart:developer';
mixin JsonUtils{
  static Map<String, dynamic>? convertStringToMap(String? value) {
    if (isValidJson(value) && json.json.decode(value!) is Map) {
      return json.json.decode(value) as Map<String, dynamic>;
    }
    return null;
  }

  static List<Map<String, dynamic>>? convertStringToListMap(String? value) {
    if (isValidJson(value) && json.json.decode(value!) is List) {
      return (json.json.decode(value) as List)
          .map((dynamic e) => e as Map<String, dynamic>)
          .toList();
    }
    return null;
  }

  static bool jsonIsList(String? value) {
    try {
      return json.json.decode(value ?? '') is List;
    } catch (error) {
      log('failure to convert $value to JSON');
      return false;
    }
  }

  static bool jsonIsObject(String? value) {
    try {
      return json.json.decode(value ?? '') is Map;
    } catch (error) {
      log('failure to convert $value to JSON');
      return false;
    }
  }

  static bool isValidJson(String? value) {
    try {
      json.json.decode(value ?? '');
      return true;
    } catch (error) {
      log('failure to convert $value to JSON');
      return false;
    }
  }
}