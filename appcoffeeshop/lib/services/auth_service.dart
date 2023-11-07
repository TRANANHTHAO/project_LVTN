import 'dart:convert';
import 'dart:async';

//import 'package:appcoffeeshop/Utils.dart';
import 'package:appcoffeeshop/services/firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../models/http_exception.dart';
import '../models/auth_token.dart';
import 'firebase_realtime_service.dart';

class AuthService extends FirebaseService {
  static const _authTokenKey = 'authToken';
  static var isAdmin = false;
  late final String? _apiKey;
  late final CollectionReference<Map<String, dynamic>> usersCollection;
  late final FirebaseRealtimeService firebaseRealtimeService;

  AuthService() {
    clearAll();
    usersCollection = getUsers();
    _apiKey = dotenv.env['FIREBASE_API_KEY'];
    firebaseRealtimeService = FirebaseRealtimeService();
  }

  String _buildAuthUrl(String method) {
    return 'https://identitytoolkit.googleapis.com/v1/accounts:$method?key=$_apiKey';
  }

  Future<AuthToken> _authenticate(
      String email, String password, String method, bool isEnableMode) async {
    try {
      final url = Uri.parse(_buildAuthUrl(method));
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final responseJson = json.decode(response.body);
      if (responseJson['error'] != null) {
        throw HttpException.firebase(responseJson['error']['message']);
      }

      final authToken = _fromJson(responseJson);
      if (method == 'signUp') {
        await usersCollection.doc(authToken.userId).get().then((value) async {
          if (!value.exists) {
            await usersCollection.doc(authToken.userId).set({
              'email': email,
              'userId': authToken.userId,
              'admin': isEnableMode,
              'orders': [],
            });
            _saveIdAdmin(isEnableMode);
            _saveAuthToken(authToken);
            _saveEmailUser(email);
            isAdmin = isEnableMode;
          } else {
            throw HttpException.firebase("Tài khoản của bạn đã tồn tại");
          }
        }).onError((error, stackTrace) {
          throw HttpException.firebase("Tài khoản của bạn không tồn tại");
        });
      } else if (method == 'signInWithPassword') {
        await usersCollection.doc(authToken.userId).get().then((value) => {
              if (!value['admin'] && isEnableMode == true)
                {
                  throw HttpException.firebase(
                      "Tài khoản của bạn không phải admin")
                }
              else if (value['admin'] && isEnableMode == false)
                {
                  throw HttpException.firebase(
                      "Tài khoản của bạn là admin, vui lòng bật admin mode")
                }
              else
                {
                  _saveIdAdmin(value['admin']),
                  isAdmin = value['admin'],
                  _saveAuthToken(authToken),
                  _saveEmailUser(email),
                }
            });
      }
      firebaseRealtimeService.init();

      return authToken;
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<AuthToken> signup(String email, String password, bool isModeAdmin) {
    return _authenticate(email, password, 'signUp', isModeAdmin);
  }

  Future<AuthToken> login(String email, String password, bool isModeAdmin) {
    return _authenticate(email, password, 'signInWithPassword', isModeAdmin);
  }

  Future<void> _saveAuthToken(AuthToken authToken) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_authTokenKey, json.encode(authToken.toJson()));
  }

  Future<void> _saveIdAdmin(bool isAdmin) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isAdmin', isAdmin);
  }

  Future<void> _saveEmailUser(String email) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('email', email);
  }

  AuthToken _fromJson(Map<String, dynamic> json) {
    return AuthToken(
      token: json['idToken'],
      userId: json['localId'],
      expiryDate: DateTime.now().add(
        Duration(
          seconds: int.parse(
            json['expiresIn'],
          ),
        ),
      ),
    );
  }

  Future<AuthToken?> loadSavedAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(_authTokenKey)) {
      return null;
    }

    final savedToken = prefs.getString(_authTokenKey);

    final authToken = AuthToken.fromJson(json.decode(savedToken!));
    if (!authToken.isValid) {
      return null;
    }
    return authToken;
  }

  Future<void> clearSavedAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_authTokenKey);
  }

  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
