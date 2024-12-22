import 'dart:convert';
import 'dart:developer';

import 'package:atef_physics/core/models/user_model.dart';
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
  bool get isDarkMood => false;

  set isDarkMood(bool isDarkMood) =>
      prefs.setBool(StorageKeys.isDarkMood, isDarkMood);

  /// Getter and Setter for First Time Usage
  bool get isFirstTime => prefs.getBool(StorageKeys.isFirstTime) ?? true;

  set isFirstTime(bool isFirstTime) =>
      prefs.setBool(StorageKeys.isFirstTime, isFirstTime);

  bool get isAuth {
    final userdata = prefs.getString(StorageKeys.user);
    log("User Data $userdata");
    if (userdata == null) {
      return false;
    } else {
      return true;
    }
  }

  UserModel get user =>
      UserModel.fromJson(json.decode(prefs.getString(StorageKeys.user)!));

  set user(UserModel user) =>
      prefs.setString(StorageKeys.user, json.encode(user.toJson()));

  Future<void> logout()async =>await prefs.remove(StorageKeys.user);
}
