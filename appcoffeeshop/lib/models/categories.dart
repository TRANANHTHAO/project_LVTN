//import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class Categories {
  final int id;
  final String tenloai;
  final String slug;
  final String? mota;
  final String? hinhanh;
  final int trangthai;
  final String? created_at;
  final String? updated_at;

  Categories({
    required this.id,
    required this.tenloai,
    required this.slug,
    this.mota = "",
    this.hinhanh,
    required this.trangthai,
    this.created_at,
    this.updated_at,
  });


  Categories copyWith({
    int? id,
    String? tenloai,
    String? slug,
    String? mota,
    String? hinhanh,
    int? trangthai,
    String? created_at,
    String? updated_at
  }) {
    return Categories(
      id: id ?? this.id,
      tenloai: tenloai ?? this.tenloai,
      slug: slug ?? this.slug,
      mota: mota ?? this.mota,
      hinhanh: hinhanh ?? this.hinhanh,
      trangthai: trangthai ?? this.trangthai,
      created_at: created_at ?? this.created_at,
      updated_at: updated_at ?? this.updated_at
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tenloai': tenloai,
      'slug': slug,
      'mota': mota,
      'hinhanh': hinhanh,
      'trangthai': trangthai,
      'created_at': created_at,
      'updated_at': updated_at,
    };
  }

  static Categories fromJson(Map<String, dynamic> json) {
    return Categories(
      id: int.parse(json['id']),
      tenloai: json['tenloai'],
      slug: json['slug'],
      mota: json['mota'],
      hinhanh: json['hinhanh'],
      trangthai: int.parse(json['trangthai']),
      created_at: json['created_at'],
      updated_at: json['updated_at'],
    );
  }
}
