//import 'dart:convert';

import 'package:appcoffeeshop/Utils.dart';
//import 'package:appcoffeeshop/models/order_item.dart';
//import 'package:appcoffeeshop/models/order_status.dart';
import 'package:firebase_database/firebase_database.dart';

import '../notifications.dart';
//import 'firebase_service.dart';

class FirebaseRealtimeService {
  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;

  NotificationService notificationService = NotificationService();

  FirebaseRealtimeService() {}

  Future<void> init() async {
    final isAdmin = await Utils.getIsAdmin();
    if (isAdmin) {
      _favoriteListener();
      _orderListener();
    }
  }

  Future<void> notifyFavorite(String creatorId, bool isFavorite) async {
    final userId = await Utils.getUserid();
    final isAdmin = await Utils.getIsAdmin();
    final ref = firebaseDatabase.ref('notification/favorite').child(userId);
    if (!isAdmin) {
      await ref.set({
        'creatorId': creatorId,
        'isFavorite': isFavorite,
        'isNotify': false,
      });
    }
  }

  Future<void> notifyOrder(String creatorId) async {
    final userId = await Utils.getUserid();
    final isAdmin = await Utils.getIsAdmin();
    final ref = firebaseDatabase.ref('notification/order').child(userId);
    if (!isAdmin) {
      await ref.set({
        'creatorId': creatorId,
        'isNotify': false,
      });
    }
  }

  _favoriteListener() async {
    final userId = await Utils.getUserid();
    var isShowNotify = false;
    firebaseDatabase
        .ref('notification')
        .child('favorite')
        .onValue
        .listen((event) async {
      print("Favorite : ${event.type}");
      var value = event.snapshot.value as Map<dynamic, dynamic>;
      value.forEach((keyClient, valueHost) async {
        print(keyClient);
        var mapValueHost = valueHost as Map<dynamic, dynamic>;
        var createId = '';
        var isFavorite = false;
        mapValueHost.forEach((key, value) async {
          if (key == 'creatorId' && value == userId) {
            createId = value;
          }
          if (key == 'isFavorite') {
            isFavorite = value;
          }
          if (key == 'isNotify' && value == false) {
            isShowNotify = true;
            print('Show notification');
            await firebaseDatabase
                .ref('notification/favorite')
                .child(keyClient)
                .update({'isNotify': true})
                .then((value) => print('Favorite ok'))
                .onError((error, stackTrace) => print(error.toString()));
          }
        });
        if (isShowNotify && createId != '' && isFavorite == true) {
          print('Show notification');
          notificationService.showLocalNotification(
            'Được yêu thích',
            'Sản phẩm của bạn đã được yêu thích',
          );
        }
      });
    });
  }

  _orderListener() async {
    final userId = await Utils.getUserid();
    var isShowNotify = false;
    firebaseDatabase
        .ref('notification')
        .child('order')
        .onValue
        .listen((event) async {
      print(event.type);
      var value = event.snapshot.value as Map<dynamic, dynamic>;
      value.forEach((keyClient, valueHost) async {
        print(keyClient);
        var mapValueHost = valueHost as Map<dynamic, dynamic>;
        var createId = '';
        mapValueHost.forEach((key, value) async {
          if (key == 'creatorId' && value == userId) {
            createId = value;
          }
          if (key == 'isNotify' && value == false) {
            isShowNotify = true;
            await firebaseDatabase
                .ref('notification/order')
                .child(keyClient)
                .update({'isNotify': true})
                .then((value) => print('Order ok'))
                .onError((error, stackTrace) => print(error.toString()));
          }
        });
        if (isShowNotify && createId != '') {
          print('Show notification');
          notificationService.showLocalNotification(
            'Bạn có đơn hàng mới',
            'Bạn có đơn đặt hàng mới, vui lòng kiểm tra',
          );
        }
      });
    });
  }
}
