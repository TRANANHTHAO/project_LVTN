import 'package:flutter/material.dart';

import 'package:appcoffeeshop/ui/cart/cart_manager.dart';
import 'package:provider/provider.dart';
import '../../models/cart_item.dart';

class QuantityButton extends StatelessWidget {
  const QuantityButton(
    this.cartItem,
    this.productId, {
    super.key,
  });

  final CartItem cartItem;
  final String productId;
  @override
  Widget build(BuildContext context) {
    final cart = context.read<CartManager>();
    return RichText(
      text: TextSpan(
        children: [
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: IconButton(
              icon: const Icon(
                Icons.remove,
                size: 15,
                color: Colors.white,
              ),
              onPressed: () {
                if (cart.checkQuantity(productId) == true) {
                  showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                            title: const Text('Xác Nhận:'),
                            content: const Text('Xoá sản phẩm Giỏ Hàng?'),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Không'),
                                onPressed: () {
                                  Navigator.of(ctx).pop(false);
                                },
                              ),
                              TextButton(
                                child: const Text(
                                  'Có',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                onPressed: () {
                                  cart.removeSingleItem(productId);
                                  Navigator.of(ctx).pop(true);
                                },
                              ),
                            ],
                          ));
                } else {
                  cart.removeSingleItem(productId);
                }
              },
            ),
          ),
          TextSpan(
            text: '${cartItem.quantity}',
            style: const TextStyle(color: Colors.white, fontSize: 15),
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: IconButton(
              icon: const Icon(
                Icons.add,
                size: 15,
                color: Colors.white,
              ),
              onPressed: () {
                cart.addSingleItem(productId);
              },
            ),
          ),
        ],
      ),
    );
  }
}
