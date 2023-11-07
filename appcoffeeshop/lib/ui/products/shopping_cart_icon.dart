import 'package:flutter/material.dart';
import 'package:appcoffeeshop/ui/cart/cart_manager.dart';
//import 'package:appcoffeeshop/ui/cart/cart_screen.dart';
import 'package:appcoffeeshop/ui/products/top_right_badge.dart';
import 'package:provider/provider.dart';
import 'package:appcoffeeshop/ui/products/top_right_bottom_badge.dart';

Widget buildIconShoppingCart() {
  return Consumer<CartManager>(
    builder: (ctx, cartManager, child) {
      return TopRightBadge(
        data: cartManager.productCount,
        child: const Icon(
          Icons.shopping_cart,
          size: 25,
        ),
      );
    },
  );
}

Widget builIcondShoppingCartActive() {
  return Consumer<CartManager>(
    builder: (ctx, cartManager, child) {
      return TopRightBottomBadge(
        data: cartManager.productCount,
        child: const Icon(
          Icons.shopping_cart,
          size: 25,
        ),
      );
    },
  );
}

Widget buildIconShoppingCartBottom() {
  return Consumer<CartManager>(
    builder: (ctx, cartManager, child) {
      return TopRightBottomBadge(
        data: cartManager.productCount,
        child: const Icon(
          Icons.shopping_cart_outlined,
          size: 28,
        ),
      );
    },
  );
}
