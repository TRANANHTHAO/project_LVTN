//import 'package:appcoffeeshop/ui/shared/bottom_navigator_bar.dart';
import 'package:flutter/material.dart';

import 'cart_manager.dart';
import 'cart_item_card.dart';
import 'package:provider/provider.dart';
import '../orders/orders_manager.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreen();
}

class _CartScreen extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartManager>();
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
          'Giỏ Hàng',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: 'Lato', fontWeight: FontWeight.bold, wordSpacing: 2),
        ),
        flexibleSpace: Container(
          color: const Color.fromARGB(255, 19, 18, 18),
        ),
      ),
      body: Column(
        children: <Widget>[
          //buildCartSummary(cart, context),
          const SizedBox(height: 15),
          Expanded(
            child: buildCartDetails(cart),
          ),
          buildCartSummary(cart, context),
        ],
      ),
    );
  }

  Widget buildCartDetails(CartManager cart) {
    return ListView(
      children: cart.productEntries
          .map(
            (entry) => CartItemCard(
              productId: entry.key,
              cartItem: entry.value,
            ),
          )
          .toList(),
    );
  }

  Widget buildCartSummary(CartManager cart, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      height: 130,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Tổng Cộng :',
                style: TextStyle(
                  letterSpacing: 2,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Chip(
                label: Text(
                  '${cart.totalAmount.toStringAsFixed(2)}0 VND',
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).primaryTextTheme.headline6?.color,
                  ),
                ),
                backgroundColor: Theme.of(context).primaryColor,
              ),
            ],
          ),
          Container(
            alignment: Alignment.center,
            height: 40,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 236, 62, 9),
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextButton(
              onPressed: cart.totalAmount <= 0
                  ? null
                  : () {
                      context.read<OrdersManager>().showBottomSheet(
                            context,
                            cart.products,
                            cart.totalAmount,
                            () => cart.clear(),
                          );
                    },
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 38.0,
                  vertical: 12.0,
                ),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                backgroundColor: const Color.fromARGB(255, 236, 62, 9),
              ),
              child: const Text(
                'ĐẶT HÀNG',
                style: TextStyle(
                  //fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
