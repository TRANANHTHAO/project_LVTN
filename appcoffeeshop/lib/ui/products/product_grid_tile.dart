import 'package:flutter/material.dart';

import '../../models/product.dart';

import 'product_detail_screen.dart';
import 'package:provider/provider.dart';
import '../cart/cart_manager.dart';
import '../products/products_manager.dart';

class ProductGridTile extends StatelessWidget {
  const ProductGridTile(
    this.product, {
    super.key,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            // Navigator.of(context).pushNamed(
            //   ProductDetailScreen.routeName,
            //   arguments: product.id,
            // );
            Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => ProductDetailScreen(product))
            );
          },
          child: Container(
            height: 250,
            width: 170,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.8),
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 135,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: NetworkImage(
                        product.imageUrl,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ValueListenableBuilder<int>(
                          valueListenable: product.numberFavoriteListener,
                          builder: (ctx, isFavorite, child) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                left: 78.0,
                                top: 11,
                              ),
                              child: Text(
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                                isFavorite.toString(),
                                //textAlign: TextAlign.right,
                              ),
                            );
                          },
                        ),
                      ),
                      ValueListenableBuilder<bool>(
                        valueListenable: product.isFavoriteListenable,
                        builder: (ctx, isFavorite, child) {
                          return IconButton(
                            icon: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: const Color.fromARGB(255, 239, 91, 46),
                              size: 22,
                            ),
                            alignment: Alignment.topRight,
                            padding: const EdgeInsets.only(
                              right: 10.0,
                              top: 10.0,
                            ),
                            color: Theme.of(context).colorScheme.secondary,
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
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${product.price} VND',
                            style: const TextStyle(
                              color: Color.fromARGB(255, 239, 91, 46),
                              fontSize: 14,
                            ),
                          ),
                          Container(
                            //alignment: Alignment.center,
                            width: 30,
                            height: 30,
                            // padding: const EdgeInsets.only(
                            //   right: 30,
                            //   bottom: 30,
                            // ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromARGB(255, 239, 91, 46),
                            ),
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              alignment: Alignment.center,
                              icon: const Icon(
                                Icons.add,
                                size: 20,
                                color: Colors.white,
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
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
