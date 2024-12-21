import 'dart:convert';

import 'package:atef_physics/features/Auth/data/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:atef_physics/core/constants/storage_keys.dart';

class Storage {
  static final Storage _instance = Storage._();

  late SharedPreferences prefs;

  Storage._();

  static Storage get instance => _instance;

  /// Initialize SharedPreferences
  Future<void> initStorage() async {
    prefs = await SharedPreferences.getInstance();
  }

  /// Getter and Setter for Dark Mode Preference
  bool get isDarkMood => prefs.getBool(StorageKeys.isDarkMood) ?? true;

  set isDarkMood(bool isDarkMood) =>
      prefs.setBool(StorageKeys.isDarkMood, isDarkMood);

  /// Getter and Setter for First Time Usage
  bool get isFirstTime => prefs.getBool(StorageKeys.isFirstTime) ?? true;

  set isFirstTime(bool isFirstTime) =>
      prefs.setBool(StorageKeys.isFirstTime, isFirstTime);

  bool get isAuth {
    final userdata = prefs.getString(StorageKeys.user);
    if (userdata == null) {
      return false;
    } else {
      return true;
    }
  }

  UserModel get user =>
      UserModel.fromJson(jsonDecode(prefs.getString(StorageKeys.user)!));

  set user(UserModel user) =>
      prefs.setString(StorageKeys.user, user.toJson().toString());
  Future<void> logout() => prefs.remove(StorageKeys.user);
}
