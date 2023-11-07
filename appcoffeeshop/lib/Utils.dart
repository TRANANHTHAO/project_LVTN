//import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Utils {
  static Future<String> getToken() async {
    final Future<SharedPreferences> prefs0 = SharedPreferences.getInstance();
    final SharedPreferences prefs = await prefs0;
    return prefs.getString('token') ?? "";
  }

  static Future<String> getUserid() async {
    final Future<SharedPreferences> prefs0 = SharedPreferences.getInstance();
    final SharedPreferences prefs = await prefs0;
    return prefs.getString('userId') ?? "";
  }

  static Future<bool> getIsAdmin() async {
    final Future<SharedPreferences> prefs0 = SharedPreferences.getInstance();
    final SharedPreferences prefs = await prefs0;
    return prefs.getBool('isAdmin') ?? false;
  }

  static Future<String> getEmailUser() async {
    final Future<SharedPreferences> prefs0 = SharedPreferences.getInstance();
    final SharedPreferences prefs = await prefs0;
    return prefs.getString('email') ?? '';
  }

  static DateTime parseTime(dynamic date) {
    return (date as Timestamp).toDate();
  }
}
