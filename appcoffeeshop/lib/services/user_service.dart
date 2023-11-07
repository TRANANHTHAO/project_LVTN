import 'package:appcoffeeshop/Utils.dart';
import 'package:appcoffeeshop/models/user_model.dart';
import 'package:appcoffeeshop/services/firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/auth_token.dart';

class UserService extends FirebaseService {
  late final CollectionReference<Map<String, dynamic>> userProducts;

  UserService([AuthToken? authToken]) : super(authToken) {
    userProducts = getUsers();
  }

  Future<List<UserModel>> fetchUsers() async {
    var userId = await Utils.getUserid();
    final List<UserModel> products = [];
    await userProducts.get().then(
          (value) => {
            value.docs.forEach((element) {
              if (element.id != userId) {
                var item = UserModel.fromJson(element.id, element.data()['email']);
                products.add(item);
              }
            })
          },
        );
    return products;
  }

  Future<void> removeUser(String id) async {
    await userProducts.doc(id).delete();
  }
}
