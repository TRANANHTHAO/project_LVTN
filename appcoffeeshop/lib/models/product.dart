//import 'package:flutter/cupertino.dart';
import 'package:appcoffeeshop/api/api_connection.dart';
import 'package:appcoffeeshop/cubit/products/products_cubit.dart';
import 'package:appcoffeeshop/models/product_coupon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'coupon.dart';

class Product {
  final String? id;
  final String title;
  final String description;
  final num price;
  final String imageUrl;
  final String favoriteId;
  final String commentId;
  final String creatorId;
  final String type;

  final ValueNotifier<bool> _isFavorite;
  final ValueNotifier<int> _numberFavorite;

  Product({
    this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.favoriteId,
    required this.creatorId,
    required this.commentId,
    required this.type,
    isFavorite = false,
    numberFavorite = 0,
  }) : _isFavorite = ValueNotifier(isFavorite),
      _numberFavorite = ValueNotifier(numberFavorite);

  set numberFavorite(int newValue) {
    _numberFavorite.value = newValue;
  }

  int get numberFavorite {
    return _numberFavorite.value;
  }

  ValueNotifier<int> get numberFavoriteListener {
    return _numberFavorite;
  }

  set isFavorite(bool newValue) {
    _isFavorite.value = newValue;
  }

  bool get isFavorite {
    return _isFavorite.value;
  }

  ValueNotifier<bool> get isFavoriteListenable {
    return _isFavorite;
  }

  double getDiscountPrice(BuildContext context) {
    List<ProductCoupon> _productDiscounts = context.read<ProductsCubit>().state.productCoupon;
    List<Coupon> _coupons = context.read<ProductsCubit>().state.coupons;

    if (_productDiscounts.any((coupon) => coupon.idProduct.toString() == id)) {
      ProductCoupon _discount = _productDiscounts.firstWhere(
          (discount) => discount.idProduct.toString() == id);
      Coupon _coupon = _coupons.firstWhere(
          (coupon) => coupon.id == _discount.idCoupon.toString());

      return  double.parse(_coupon.giamgia);
    } else {
      return 0;
    }
  }

  double getPriceAfterDiscount(double discount) {
    return price.toDouble() - discount;
  }

  Product copyWith({
    String? id,
    String? title,
    String? description,
    double? price,
    String? imageUrl,
    bool? isFavorite,
    String? favoriteId,
    String? creatorId,
    String? commentId,
    String? type,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      isFavorite: isFavorite ?? this.isFavorite,
      favoriteId: favoriteId ?? this.favoriteId,
      creatorId: creatorId ?? this.creatorId,
      commentId: commentId ?? this.commentId,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'favoriteId': favoriteId,
      'creatorId': creatorId,
      'commentId': commentId,
      'type': type,
    };
  }

  static Product fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price'],
      imageUrl: json['imageUrl'],
      favoriteId: json['favoriteId'],
      creatorId: json['creatorId'],
      commentId: json['commentId'],
      type: json['type'],
    );
  }

  static Product fromMySQL(Map<String, dynamic> json) {
    return Product(
      id: json['id'].toString(),
      title: json['tensp'].toString(),
      description: json['mota'].toString(),
      price: num.parse(json['giaban'].toString()),
      imageUrl: APIConnection.getImgUrl(json['hinhanh'] ?? ""),
      favoriteId: json['favoriteId'] ?? "",
      creatorId: json['creatorId'] ?? "",
      commentId: json['commentId'] ?? "",
      type: json['id_loaisanpham'].toString(),
    );
  }
}
