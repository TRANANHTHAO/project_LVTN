import 'dart:async';

import 'package:appcoffeeshop/models/user_model.dart';
import 'package:appcoffeeshop/services/user_service.dart';
import 'package:flutter/foundation.dart';
//import 'package:shared_preferences/shared_preferences.dart';

import '../../models/auth_token.dart';
//import '../../services/auth_service.dart';

class UserManager with ChangeNotifier {
  final UserService _userService;

  final String emailRoot = 'admin@gmail.com';

  UserManager([AuthToken? authToken]) : _userService = UserService(authToken);

  final List<UserModel> _users = [];

  int get orderCount {
    return _users.length;
  }

  List<UserModel> get users {
    return [..._users];
  }

  Future<void> fetchUser() async {
    var items = await _userService.fetchUsers();
    _users.clear();
    for (UserModel item in items) {
      if (item.email != emailRoot) {
        _users.add(item);
      }
    }
    notifyListeners();
  }

  Future<void> deleteUser(String id) async {
    await _userService.removeUser(id);
    await fetchUser();
  }
}
