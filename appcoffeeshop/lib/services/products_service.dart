//import 'dart:convert';

import 'package:appcoffeeshop/Utils.dart';
import 'package:appcoffeeshop/services/comment_service.dart';
import 'package:appcoffeeshop/services/favorite_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:http/http.dart' as http;

import '../models/product.dart';
import '../models/auth_token.dart';
import 'firebase_service.dart';

class ProductsService extends FirebaseService {
  late final CollectionReference<Map<String, dynamic>> collectProducts;
  final FavoriteService favoriteService = FavoriteService();
  final CommentService commentService = CommentService();

  final String emailRoot = 'admin@gmail.com';

  ProductsService([AuthToken? authToken]) : super(authToken) {
    collectProducts = getCollectProducts();
  }

  Future<List<Product>> fetchProducts([bool filterByUser = false]) async {
    final List<Product> products = [];
    var isAdmin = await Utils.getIsAdmin();
    var userId = await Utils.getUserid();
    var email = await Utils.getEmailUser();
    if (isAdmin) {
      await collectProducts.get().then((value) => {
            value.docs.forEach((element) {
              var item = Product.fromJson(element.data());
              if (email == emailRoot) {
                products.add(item);
              } else if (item.creatorId == userId) {
                products.add(item);
              }
            })
          });
    } else {
      await collectProducts.get().then((value) => {
            value.docs.forEach((element) {
              products.add(Product.fromJson(element.data()));
            })
          });
    }
    return products;
  }

  //add product

  Future<Product?> addProduct(Product product) async {
    Product? productResponse;
    var favoriteId = await favoriteService.initFavoriteForProduct();
    var userId = await Utils.getUserid();
    await collectProducts
        .add(product.toJson()
          ..addAll({
            'creatorId': userId,
            'favoriteId': favoriteId,
          }))
        .then((value) => {
              value.get().then((value2) =>
                  productResponse = Product.fromJson(value2.data()!))
            });
    return productResponse;
  }

  Future<bool> updateProduct(Product product) async {
    bool isOk = false;
    await collectProducts
        .doc(product.id)
        .update(product.toJson())
        .whenComplete(() => isOk = true);
    return isOk;
  }

  Future<bool> deleteProduct(String id) async {
    bool isOk = false;
    await collectProducts.doc(id).delete().whenComplete(() => isOk = true);
    return isOk;
  }
}
