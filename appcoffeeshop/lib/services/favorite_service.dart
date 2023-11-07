import 'package:appcoffeeshop/Utils.dart';
import 'package:appcoffeeshop/models/favorite.dart';
import 'package:appcoffeeshop/services/firebase_realtime_service.dart';
import 'package:appcoffeeshop/services/firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/auth_token.dart';
import '../models/product.dart';

class FavoriteService extends FirebaseService {
  late final CollectionReference<Map<String, dynamic>> favoriteProducts;

  FirebaseRealtimeService realtimeService = FirebaseRealtimeService();  
  
  FavoriteService([AuthToken? authToken]) : super(authToken) {
    favoriteProducts = getFavoriteProducts();
  }

  Future<String?> initFavoriteForProduct() async {
    String favoriteId;
    var result = await favoriteProducts.add({
      'number' : 0,
      'userIds': [],
    });
    favoriteId = result.id;
    return favoriteId;
  }

  Future<bool> saveFavoriteStatus(Product product) async {
    bool isOk = false;
    bool isFavorited = false;
    var userId = await Utils.getUserid();
    await favoriteProducts.doc(product.favoriteId).get().then((value) {
      var favoriteDoc = Favorite.fromJson(value.data()!);
      if (favoriteDoc.userIds.contains(userId)) {
        isFavorited = true;
      }
    });
    if (!isFavorited) {
      await favoriteProducts.doc(product.favoriteId).update({
        "userIds": FieldValue.arrayUnion([userId]),
        "number" : FieldValue.increment(1)
      }).whenComplete(() => isOk = true);
    } else {
      await favoriteProducts.doc(product.favoriteId).update({
        "userIds": FieldValue.arrayRemove([userId]),
        "number" : FieldValue.increment(-1)
      }).whenComplete(() => isOk = false);
    }
    await realtimeService.notifyFavorite(product.creatorId, isOk);
    return isOk;
  }

  Future<int> fetchNumberFavorite(Product product) async {
    int? number = 0;
    var userId = await Utils.getUserid();
    await favoriteProducts.doc(product.favoriteId).get().then((value) {
      var favoriteDoc = Favorite.fromJson(value.data()!);
      number = favoriteDoc.number?.toInt();
    });

    return number ?? 0;
  }
}
