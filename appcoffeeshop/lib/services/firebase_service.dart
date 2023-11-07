import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/auth_token.dart';

abstract class FirebaseService {

  late final FirebaseFirestore firestore;
  String? _userId;
  AuthToken? _authToken;

  set authToken(AuthToken? authToken) {
    _authToken = authToken;
  }

  FirebaseService([AuthToken? authToken]) {
    firestore = FirebaseFirestore.instance;
    _userId = authToken?.userId;
  }

  CollectionReference<Map<String, dynamic>> getCollectProducts() =>
      firestore.collection('products');

  CollectionReference<Map<String, dynamic>> getFavoriteProducts() =>
    firestore.collection("favorites");

  CollectionReference<Map<String, dynamic>> getCommentProducts() =>
      firestore.collection("commentProducts");

  CollectionReference<Map<String, dynamic>> getUsers() =>
      firestore.collection("users");

  CollectionReference<Map<String, dynamic>> getOrder() =>
      firestore.collection("orders");

  String? get userId => _userId;
}
