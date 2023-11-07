import 'package:appcoffeeshop/Utils.dart';
//import 'package:appcoffeeshop/models/product.dart';

import 'cart_item.dart';

class OrderItem {
  final String? id;
  final double amount;
  final List<CartItem>? products;
  final DateTime dateTime;
  final String orderStatus;
  final String address;
  final String sdt;
  final String ten;

  int get productCount {
    return products?.length ?? 0;
  }

  OrderItem({
    this.id,
    required this.amount,
    required this.products,
    DateTime? dateTime,
    required this.orderStatus,
    required this.address,
    required this.sdt,
    required this.ten,
  }) : dateTime = dateTime ?? DateTime.now();

  OrderItem copyWith({
    String? id,
    double? amount,
    List<CartItem>? products,
    DateTime? dateTime,
    String? orderStatus,
    String? address,
    String? sdt,
    String? ten,
  }) {
    return OrderItem(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      products: products ?? this.products,
      dateTime: dateTime ?? this.dateTime,
      orderStatus: orderStatus ?? this.orderStatus,
      address: address ?? this.address,
      sdt: sdt ?? this.sdt,
      ten: ten ?? this.ten,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'products': products?.map((e) => e.toJson()),
      'dateTime': dateTime,
      'orderStatus': orderStatus,
      'address': address,
      'sdt': sdt,
      'ten': ten,
    };
  }

  static OrderItem fromJson(String id, Map<String, dynamic> json) {
    return OrderItem(
      id: id,
      amount: json['amount'] ?? 0,
      products: (json['products'] as List<dynamic>?)
          ?.map(
              (e) => CartItem.fromJson(json['id'], (e as Map<String, dynamic>)))
          .toList(),
      dateTime: Utils.parseTime(json['dateTime']),
      orderStatus: json['orderStatus'] ?? '',
      address: json['address'] ?? '',
      sdt: json['sdt'] ?? '',
      ten: json['ten'] ?? '',
    );
  }
}
