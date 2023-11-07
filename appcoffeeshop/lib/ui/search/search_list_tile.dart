import 'package:appcoffeeshop/ui/cart/cart_manager.dart';
import 'package:appcoffeeshop/ui/products/product_detail_screen.dart';
import 'package:appcoffeeshop/ui/products/products_manager.dart';
import 'package:flutter/material.dart';

import '../../models/product.dart';
import 'package:provider/provider.dart';

class SearchListTile extends StatelessWidget {
  final Product product;

  const SearchListTile(
    this.product, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          ProductDetailScreen.routeName,
          arguments: product.id,
        );
      },
      child: Column(
        children: <Widget>[
          Container(
            height: 70,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: const Color.fromARGB(255, 19, 18, 18).withOpacity(0.85),
            ),
            child: ListTile(
              title: Text(
                product.title,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              leading: CircleAvatar(
                backgroundColor: const Color.fromARGB(255, 244, 232, 196),
                backgroundImage: NetworkImage(product.imageUrl),
              ),
              subtitle: Text(
                '${product.price}00 VND',
                style: const TextStyle(
                  color: Colors.white70,
                ),
              ),
              trailing: SizedBox(
                width: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    IconButton(
                      alignment: Alignment.centerRight,
                      icon: const Icon(
                        Icons.add_shopping_cart,
                        size: 20,
                        color: Color.fromARGB(255, 239, 91, 46),
                      ),
                      onPressed: () {
                        final cart = context.read<CartManager>();
                        cart.addItem(product);
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(
                            SnackBar(
                              content: const Text(
                                'Đã thêm sản phẩm vào giỏ',
                              ),
                              duration: const Duration(seconds: 5),
                              action: SnackBarAction(
                                label: 'Xóa',
                                textColor: Colors.blue,
                                onPressed: () {
                                  cart.removeSingleItem(product.id!);
                                },
                              ),
                            ),
                          );
                      },
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    ValueListenableBuilder<bool>(
                      valueListenable: product.isFavoriteListenable,
                      builder: (ctx, isFavorite, child) {
                        return IconButton(
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: const Color.fromARGB(255, 239, 91, 46),
                            size: 20,
                          ),
                          onPressed: () {
                            ctx
                                .read<ProductsManager>()
                                .toggleFavoriteStatus(product);
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
