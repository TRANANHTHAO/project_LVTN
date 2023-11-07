import 'package:appcoffeeshop/Utils.dart';
import 'package:appcoffeeshop/models/order_item.dart';
import 'package:appcoffeeshop/models/order_status.dart';
import 'package:appcoffeeshop/services/firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/auth_token.dart';
import 'firebase_realtime_service.dart';

class OrderService extends FirebaseService {
  late final CollectionReference<Map<String, dynamic>> orderProducts;
  late final CollectionReference<Map<String, dynamic>> usersCollection;
  FirebaseRealtimeService realtimeService = FirebaseRealtimeService();

  final String emailRoot = "admin@gmail.com";

  OrderService([AuthToken? authToken]) : super(authToken) {
    usersCollection = getUsers();
    orderProducts = getOrder();
  }

  Future<List<OrderItem>> fetchOrder() async {
    List<OrderItem> orders = [];
    List<String> orderIds = [];

    var userId = await Utils.getUserid();
    var isAdmin = await Utils.getIsAdmin();
    var emailUser = await Utils.getEmailUser();

    await usersCollection.get().then((value) => {
          value.docs.forEach((element) {
            if (element.id == userId || emailUser == emailRoot) {
              orderIds.addAll(
                  (element['orders'] as List<dynamic>).map((e) => e as String));
            }
          })
        });

    await orderProducts.get().then(
      (value) {
        value.docs.forEach((element) {
          if (orderIds.contains(element.id)) {
            var orderItem =
                OrderItem.fromJson(element.id, element.data()['order']);
            if (isAdmin) {
              orderItem.products?.forEach((item) {
                if (item.creatorIdProduct == userId || emailUser == emailRoot) {
                  orders.add(orderItem);
                }
              });
            } else {
              orders.add(orderItem);
            }
          }
        });
      },
    );
    print("Fetch order: ${orders.length}");
    return orders;
  }

  Future<void> addOrder(OrderItem orderItem) async {
    var userId = await Utils.getUserid();
    var hostOrder = orderItem.products?.map((e) => e.creatorIdProduct);
    var orderCreate = await orderProducts.add({
      'userOrder': userId,
      'hostOrder': hostOrder,
      'order': orderItem.toJson(),
    });
    usersCollection.doc(userId).update({
      'orders': FieldValue.arrayUnion([orderCreate.id]),
    });
    hostOrder?.forEach((element) {
      realtimeService.notifyOrder(element);
      usersCollection.doc(element).update({
        'orders': FieldValue.arrayUnion([orderCreate.id]),
      });
    });
  }

  Future<void> acceptOrder(OrderItem orderItem) async {
    var itemUpdated =
        orderItem.copyWith(orderStatus: OrderStatus.ACCEPTED.value);
    await orderProducts
        .doc(orderItem.id)
        .update({'order': itemUpdated.toJson()});
  }

  Future<void> denyOrder(OrderItem orderItem) async {
    var itemUpdated = orderItem.copyWith(orderStatus: OrderStatus.DENIED.value);
    await orderProducts.doc(orderItem.id).update({
      'order': {'order': itemUpdated.toJson()}
    });
  }
}
