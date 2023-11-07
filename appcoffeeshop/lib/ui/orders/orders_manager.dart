import 'package:appcoffeeshop/bottom_sheet.dart';
import 'package:appcoffeeshop/models/enum.dart';
import 'package:appcoffeeshop/models/order_status.dart';
import 'package:appcoffeeshop/services/order_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/auth_token.dart';
import '../../models/cart_item.dart';
import '../../models/order_item.dart';
import '../payment/payment_method_option_page.dart';
import '../products/product_overview_screen.dart';
import '../products/user_products_screen.dart';

class OrdersManager with ChangeNotifier {
  final OrderService _orderService;

  OrdersManager([AuthToken? authToken])
      : _orderService = OrderService(authToken);

  Future<void> fetchOrder() async {
    var items = await _orderService.fetchOrder();
    _orders.clear();
    _orders.addAll(items);
  }

  final List<OrderItem> _orders = [];

  int get orderCount {
    return _orders.length;
  }

  List<OrderItem> get orders {
    return [..._orders];
  }

  void showBottomSheet(
    BuildContext context,
    List<CartItem> cartProducts,
    double total,
    VoidCallback callback,
  ) {
    BottomSheetAddress.showBottomSheetAddress(
      context,
      (p0) => {
        if (p0['address'] != '' && p0['sdt'] != '' && p0['ten'] != '')
          {
            Navigator.of(context).pop(),
            //paypal
            Navigator.push(
                context, 
                MaterialPageRoute(builder: (_) => PaymentMethodOptionPage(
                  onCheckOut: (method) {
                    if (method == PaymentMethod.cash) {
                      showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              title: const Text('Thành công'),
                              content: const Text("Đặt hàng thành công"
                              ),
                              actions: <Widget>[
                                TextButton(
                                  style: TextButton.styleFrom(
                                    textStyle: Theme.of(context).textTheme.labelLarge,
                                  ),
                                  child: const Text('OK'),
                                  onPressed: () {
                                    // Navigator.of(context).pop();
                                    Navigator.popUntil(
                                        context,
                                        (route) => route.isFirst
                                    );
                                  },
                                ),
                              ],
                            );
                          }
                      );
                    } else {

                    }
                    // addOrder(cartProducts, total, p0['address']!, p0['sdt']!, p0['ten']!);
                  },
                ))
            ),
            // callback(),

          }
      },
    );
  }

  void addOrder(
    List<CartItem> cartProducts,
    double total,
    String address,
    String sdt,
    String ten,
  ) async {
    var orderItem = OrderItem(
      id: 'o${DateTime.now().toIso8601String()}',
      amount: total,
      products: cartProducts,
      dateTime: DateTime.now(),
      orderStatus: OrderStatus.WAITING.value,
      address: address,
      sdt: sdt,
      ten: ten,
    );
    _orders.insert(0, orderItem);
    await _orderService.addOrder(orderItem);
  }

  void acceptOrder(OrderItem orderItem) async {
    await _orderService.acceptOrder(orderItem);
  }

  void denyOrder(OrderItem orderItem) async {
    await _orderService.denyOrder(orderItem);
  }
}
