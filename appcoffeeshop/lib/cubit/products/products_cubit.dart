import 'dart:convert';

import 'package:appcoffeeshop/models/categories.dart';
import 'package:appcoffeeshop/models/product.dart';
import 'package:appcoffeeshop/models/product_coupon.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

import '../../api/api_connection.dart';
import '../../models/coupon.dart';
part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(const ProductsState());

  Future<void> init() async {
    var task = <Future>[];
    task.add(loadCategories());
    task.add(loadAllProducts());
    task.add(loadCoupon());
    task.add(loadProductCoupon());
    await Future.wait(task);
  }

  Future<void> loadAllProducts() async {
    try {
      Response? response = await APIConnection().getAllProducts()
          .timeout(APIConnection.timeOut);

      if (response == null) return;

      if (response.statusCode == 200) {
        List _body = jsonDecode(response.body);
        
        List<Product> _products = _body.map(
            (json) => Product.fromMySQL(json)).toList();
        emit(state.copyWith(allProducts: _products));
      }
    } catch (err) {
      print(err);
    }
  }

  List<Product> getProductsByType(int type) {
    return List<Product>.from(state.allProducts)
        .where((element) => element.type == type.toString())
        .toList();

  }

  Future<void> loadCoupon() async {
    try {
      Response? response = await APIConnection().getCoupon()
          .timeout(APIConnection.timeOut);

      if (response == null) return;

      if (response.statusCode == 200) {
        List _body = jsonDecode(response.body);

        List<Coupon> _coupons = _body.map(
                (json) => Coupon.fromJson(json)).toList();
        emit(state.copyWith(coupons: _coupons));
      }
    } catch (err) {
      print(err);
    }
  }

  Future<void> loadProductCoupon() async {
    try {
      Response? response = await APIConnection().getProductCoupon()
          .timeout(APIConnection.timeOut);

      if (response == null) return;

      if (response.statusCode == 200) {
        List _body = jsonDecode(response.body);

        List<ProductCoupon> _productCoupon = _body.map(
                (json) => ProductCoupon.fromJson(json)).toList();
        emit(state.copyWith(productCoupon: _productCoupon));
      }
    } catch (err) {
      print(err);
    }
  }

  Future<void> loadCategories() async {
    try {
      Response? response = await APIConnection().getCategories()
          .timeout(APIConnection.timeOut);

      if (response == null) return;

      if (response.statusCode == 200) {
        List _body = jsonDecode(response.body);

        List<Categories> _categories = _body.map(
                (json) => Categories.fromJson(json)).toList();
        emit(state.copyWith(categories: _categories));
      }
    } catch (err) {
      print(err);
    }
  }

}