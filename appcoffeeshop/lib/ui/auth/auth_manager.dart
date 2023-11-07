import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/auth_token.dart';
import '../../services/auth_service.dart';

class AuthManager with ChangeNotifier {
  AuthToken? _authToken;
  Timer? _authTimer;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  final AuthService _authService = AuthService();

  bool get isAuth {
    return authToken != null && authToken!.isValid;
  }

  AuthToken? get authToken {
    return _authToken;
  }

  void _setAuthToken(AuthToken token) {
    _authToken = token;
    _autoLogout();
    saveToken();
    notifyListeners();
  }

  Future<void> signup(String email, String password, bool isModeAdmin) async {
    _setAuthToken(await _authService.signup(email, password, isModeAdmin));
  }

  Future<void> login(String email, String password, bool isModeAdmin) async {
    _setAuthToken(await _authService.login(email, password, isModeAdmin));
  }

  Future<bool> tryAutoLogin() async {
    final savedToken = await _authService.loadSavedAuthToken();
    if (savedToken == null) {
      return false;
    }

    _setAuthToken(savedToken);
    return true;
  }

  Future<void> logout() async {
    _authToken = null;
    if (_authTimer != null) {
      _authTimer!.cancel();
      _authTimer = null;
    }
    notifyListeners();
    _authService.clearSavedAuthToken();
  }

  Future<void> saveToken() async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString('token', _authToken?.token ?? "");
    prefs.setString('userId', _authToken?.userId ?? "");
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer!.cancel();
    }
    final timeToExpiry =
        _authToken!.expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }
}
