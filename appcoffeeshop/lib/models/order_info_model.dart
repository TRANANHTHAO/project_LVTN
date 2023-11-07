import 'package:appcoffeeshop/Utils.dart';
import 'cart_item.dart';

class OrderInformation {
  final List productList;
  final double totalPrice;
  final String address;
  final String phoneNum;
  final String name;

  OrderInformation({
    required this.productList,
    required this.totalPrice,
    required this.address,
    required this.phoneNum,
    required this.name
  });

  OrderInformation copyWith({
    List? productList,
    double? totalPrice,
    String? address,
    String? phoneNum,
    String? name,
  }) {
    return OrderInformation(
        productList: productList ?? this.productList,
        totalPrice: totalPrice ?? this.totalPrice,
        address: address ?? this.address,
        phoneNum: phoneNum ?? this.phoneNum,
        name: name ?? this.name
    );
  }
  //
  // Map<String, dynamic> toJson() {
  //   return {
  //     'id': id,
  //     'amount': amount,
  //     'products': products?.map((e) => e.toJson()),
  //     'dateTime': dateTime,
  //     'orderStatus': orderStatus,
  //     'address': address,
  //     'sdt': sdt,
  //     'ten': ten,
  //   };
  // }
  //
  // static OrderInformation fromJson(String id, Map<String, dynamic> json) {
  //   return OrderInformation(
  //     id: id,
  //     amount: json['amount'] ?? 0,
  //     products: (json['products'] as List<dynamic>?)
  //         ?.map(
  //             (e) => CartItem.fromJson(json['id'], (e as Map<String, dynamic>)))
  //         .toList(),
  //     dateTime: Utils.parseTime(json['dateTime']),
  //     orderStatus: json['orderStatus'] ?? '',
  //     address: json['address'] ?? '',
  //     sdt: json['sdt'] ?? '',
  //     ten: json['ten'] ?? '',
  //   );
  // }
}
