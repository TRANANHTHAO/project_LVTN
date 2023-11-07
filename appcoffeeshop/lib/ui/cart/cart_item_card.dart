import 'package:flutter/material.dart';
import 'package:appcoffeeshop/models/quantity_button.dart';

import '../../models/cart_item.dart';
import '../shared/dialog_utils.dart';

import 'package:provider/provider.dart';
import 'cart_manager.dart';

class CartItemCard extends StatelessWidget {
  final String productId;
  final CartItem cartItem;

  const CartItemCard({
    required this.productId,
    required this.cartItem,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(cartItem.id),
      background: Container(
        color: Theme.of(context).errorColor,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 4,
        ),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showConfirmDialog(
          context,
          'Bạn có muốn xóa mặt hàng khỏi giỏ hàng không?',
        );
      },
      onDismissed: (direction) {
        context.read<CartManager>().removeItem(productId);
      },
      child: buildItemCard(),
    );
  }

  Widget buildItemCard() {
    return Card(
      //color: Color.fromARGB(255, 243, 214, 186),
      color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.8),
      margin: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 8,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: ListTile(
          leading: CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(cartItem.imageUrl),
          ),
          title: Text(
            cartItem.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              wordSpacing: 3,
              color: Colors.white,
            ),
          ),

          subtitle: Text(
            textAlign: TextAlign.start,
            'Tổng: ${(cartItem.price * cartItem.quantity)}00 VND',
            style: const TextStyle(
              color: Color.fromARGB(255, 255, 194, 25),
              wordSpacing: 2,
            ),
          ),
          // trailing: Padding(
          //   padding: EdgeInsets.all(2),
          //   child: Row(
          //     children: [
          //       QuantityButton(cartItem, productId),
          //     ],
          //   ),
          // ),
          trailing: QuantityButton(cartItem, productId),
        ),
      ),
    );
  }
}
