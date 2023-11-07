//import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

//import '../products/product_overview_screen.dart';
import 'orders_manager.dart';
import 'order_item_card.dart';

//import '../shared/app_drawer.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';
  const OrdersScreen({super.key});

  Future<void> _refreshOrders(BuildContext context) async {
    await context.read<OrdersManager>().fetchOrder();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 105,
        leadingWidth: 50,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/');
          },
        ),
        title: const Text(
          'Đơn Hàng',
          style: TextStyle(
            fontFamily: 'Lato',
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        flexibleSpace: Container(
          color: const Color.fromARGB(255, 19, 18, 18),
        ),
      ),
      //drawer: const AppDrawer(),
      body: FutureBuilder(
        future: _refreshOrders(context),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return RefreshIndicator(
            onRefresh: () => _refreshOrders(context),
            child: Consumer<OrdersManager>(
              builder: (ctx, ordersManager, child) {
                return ListView.builder(
                  itemCount: ordersManager.orderCount,
                  itemBuilder: (ctx, i) =>
                      OrderItemCard(ordersManager.orders[i]),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
