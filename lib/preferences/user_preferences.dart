import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

abstract class JsonSerializable {
  Map<String, dynamic> toJson();
// Consider adding a factory constructor or static method in this interface for deserialization if possible
}

class SharedPreferencesHelper {
  static Future<bool> saveObject<T extends JsonSerializable>(
      String key, T value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonValue = json.encode(value.toJson());
    return await prefs.setString(key, jsonValue);
  }

  static Future<T?> getObject<T extends JsonSerializable>(
      String key, T Function(Map<String, dynamic>) fromJson) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonValue = prefs.getString(key);
    if (jsonValue != null) {
      Map<String, dynamic> jsonMap = json.decode(jsonValue);
      T object = fromJson(jsonMap);
      return object;
    }
    return null;
  }

  static Future<bool> isSharedPreferenceContainKey(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }

  // Method to save a string value
  static Future<bool> saveString(String key, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(key, value);
  }

  // Method to retrieve a string value
  static Future<String?> getString(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  // Method to retrieve a string value
  static Future<bool?> removeKey(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }

  // Method to clear all the preferences
  static Future<bool> clearAll() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }

  static Future<bool> removeData(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.remove(key);
  }

  static Future<bool> updateObjectField<T extends JsonSerializable>(
      String key, String fieldName, dynamic fieldValue) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString(key);
    if (jsonString != null) {
      Map<String, dynamic> jsonObject = json.decode(jsonString);
      if (jsonObject.containsKey(fieldName)) {
        jsonObject[fieldName] = fieldValue;
        String updatedJsonString = json.encode(jsonObject);
        return await prefs.setString(key, updatedJsonString);
      } else {
        throw ArgumentError('Field $fieldName not found in object.');
      }
    } else {
      throw ArgumentError('Object with key $key not found in SharedPreferences.');
    }
  }

}