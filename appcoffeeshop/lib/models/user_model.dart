//import 'package:flutter/foundation.dart';

class UserModel {
  final String? id;
  final String? email;

  UserModel({
    this.id,
    this.email,
  });

  UserModel copyWith({
    String? id,
    String? email,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
    };
  }

  static UserModel fromJson(String id, String email) {
    return UserModel(
      id: id,
      email: email,
    );
  }
}
