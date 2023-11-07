//import 'package:appcoffeeshop/ui/cart/cart_manager.dart';
//import 'package:appcoffeeshop/ui/orders/orders_manager.dart';
import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';

class BottomSheetAddress {
  static void showBottomSheetAddress(
    BuildContext context,
    Function(Map<String, String>) callback,
  ) {
    String textNotiName = "Không để trống tên người đặt!";
    String textNotiDiaChi = "Không để trống địa chỉ!";

    String textNotiSdt = "Không để trống số điện thoại!";

    //final cart = context.watch<CartManager>();
    final Map<String, String> data = {'address': '', 'sdt': '', 'ten': ''};
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (c) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topRight: Radius.circular(16), topLeft: Radius.circular(16))
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16,),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Tên người đặt',
                labelStyle: TextStyle(
                  color: Colors.deepOrangeAccent,
                ),
                icon: Icon(
                  Icons.person,
                  color: Colors.deepOrangeAccent,
                ),
              ),
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Không để trống tên người đặt!';
                }
                return null;
              },
              onChanged: (value) {
                data['ten'] = value;
              },
            ),
            const SizedBox(height: 16,),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Địa chỉ nhận',
                labelStyle: TextStyle(
                  color: Colors.deepOrangeAccent,
                ),
                icon: Icon(
                  Icons.maps_home_work,
                  color: Colors.deepOrangeAccent,
                ),
              ),
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Không để trống địa chỉ!';
                }
                return null;
              },
              onChanged: (value) {
                data['address'] = value;
              },
            ),
            const SizedBox(height: 16,),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Số điện thoại',
                labelStyle: TextStyle(
                  color: Colors.deepOrangeAccent,
                ),
                icon: Icon(
                  Icons.phone_android,
                  color: Colors.deepOrangeAccent,
                ),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Không để trống số điện thoại!';
                }
                return null;
              },
              onChanged: (value) {
                data['sdt'] = value;
              },
            ),
            const SizedBox(height: 24,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 236, 62, 9),
                  ),
                  onPressed: () {
                    if (data['ten']! == '') {
                      print(textNotiName);
                      _showDialog(context, textNotiName);
                      return;
                    }
                    if (data['address']! == '') {
                      print(textNotiDiaChi);
                      _showDialog(context, textNotiDiaChi);
                      return;
                    }
                    if (data['sdt']! == '') {
                      print(textNotiSdt);
                      _showDialog(context, textNotiSdt);
                      return;
                    }
                    print(data);
                    callback(data);
                  },
                  child: const Text('Đặt Hàng'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 216, 24, 10),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Hủy'),
                ),
              ],
            ),
            const SizedBox(height: 16,),
          ],
        ),
      ),
    );
  }

  static _showDialog(BuildContext context, String text) {
    showDialog(
      context: context,
      builder: ((context) {
        return AlertDialog(
          title: Text(text),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('close'))
          ],
        );
      }),
    );
  }
}
