//import 'package:flutter/cupertino.dart';
import 'package:appcoffeeshop/api/api_connection.dart';
import 'package:flutter/foundation.dart';

class Coupon {
  String id;
  String ten;
  String? hinhanh;
  String? code;
  String mota;
  String ngaybd;
  String ngaykt;
  String giamgia;
  String? dieukien;
  String loaigiam;
  String hienthi;
  String trangthai;
  String? createdAt;
  String? updatedAt;

  Coupon({
    required this.id,
    required this.ten,
    this.hinhanh,
    this.code,
    required this.mota,
    required this.ngaybd,
    required this.ngaykt,
    required this.giamgia,
    this.dieukien,
    required this.loaigiam,
    required this.hienthi,
    required this.trangthai,
    this.createdAt,
    this.updatedAt
  });

  factory Coupon.fromJson(Map<String, dynamic> json)
    => Coupon(
      id: json['id'].toString(),
      ten: json['ten'] ?? "",
      hinhanh: json['hinhanh'],
      code: json['code'],
      mota: json['mota'] ?? "",
      ngaybd: json['ngaybd'] ?? "",
      ngaykt: json['ngaykt'] ?? "",
      giamgia: json['giamgia'] ?? "",
      dieukien: json['dieukien'],
      loaigiam: json['loaigiam'] ?? "",
      hienthi: json['hienthi'] ?? "",
      trangthai: json['trangthai'] ?? "",
      createdAt: json['created_at'],
      updatedAt: json['updated_at']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ten'] = this.ten;
    data['hinhanh'] = this.hinhanh;
    data['code'] = this.code;
    data['mota'] = this.mota;
    data['ngaybd'] = this.ngaybd;
    data['ngaykt'] = this.ngaykt;
    data['giamgia'] = this.giamgia;
    data['dieukien'] = this.dieukien;
    data['loaigiam'] = this.loaigiam;
    data['hienthi'] = this.hienthi;
    data['trangthai'] = this.trangthai;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
