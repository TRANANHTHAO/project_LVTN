//import 'package:flutter/cupertino.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;
  final String imageUrl;
  final String creatorIdProduct;

  CartItem({
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
    required this.imageUrl,
    required this.creatorIdProduct,
  });

  CartItem copyWith({
    String? id,
    String? title,
    int? quantity,
    double? price,
    String? imageUrl,
    String? creatorIdProduct,
  }) {
    return CartItem(
      id: id ?? this.id,
      title: title ?? this.title,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      creatorIdProduct: creatorIdProduct ?? this.creatorIdProduct,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'quantity': quantity,
      'price': price,
      'imageUrl': imageUrl,
      'creatorIdProduct': creatorIdProduct,
    };
  }

  static CartItem fromJson(String id, Map<String, dynamic> json) {
    return CartItem(
      id: id,
      title: json['title'],
      quantity: json['quantity'],
      price: json['price'],
      imageUrl: json['imageUrl'],
      creatorIdProduct: json['creatorIdProduct'],
    );
  }
}
