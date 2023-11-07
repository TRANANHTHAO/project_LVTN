//import 'package:flutter/cupertino.dart';
//import 'package:flutter/foundation.dart';

class Favorite {
  final String? id;
  final num? number;
  final List<String> userIds;

  Favorite({
    this.id,
    required this.number,
    required this.userIds,
  });

  Favorite copyWith({
    String? id,
    num? number,
    List<String>? userIds,
  }) {
    return Favorite(
      id: id ?? this.id,
      number: number ?? this.number,
      userIds: userIds ?? this.userIds,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'userIds': userIds,
    };
  }

  static Favorite fromJson(Map<String, dynamic> json) {
    return Favorite(
      id: json['id'],
      number: json['number'],
      userIds:
          (json['userIds'] as List<dynamic>).map((e) => e as String).toList(),
    );
  }
}
