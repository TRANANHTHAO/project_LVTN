import 'package:flutter/material.dart';

import 'product_grid_tile.dart';

import 'products_manager.dart';

import '../../models/product.dart';
import 'package:provider/provider.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavorites;
  final List<Product> products;

  const ProductsGrid(this.showFavorites, {super.key, this.products = const []});

  @override
  Widget build(BuildContext context) {
    // Đọc ra danh sách các product sẽ được hiển thị từ ProductsManager
    // final products = context.select<ProductsManager, List<Product>>(
    //     (productsManager) => showFavorites
    //         ? productsManager.favoriteItems
    //         : productsManager.items);
    // return GridView.builder(
    //   padding: const EdgeInsets.all(15.0),
    //   itemCount: products.length,
    //   itemBuilder: (ctx, i) => ProductGridTile(products[i]),
    //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //     crossAxisCount: 2,
    //     childAspectRatio: 2 / 2.5,
    //     crossAxisSpacing: 10,
    //     mainAxisSpacing: 15,
    //   ),
    // );

    return GridView.builder(
      padding: const EdgeInsets.all(15.0),
      itemCount: products.length,
      itemBuilder: (ctx, i) => ProductGridTile(products[i]),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 2.5,
        crossAxisSpacing: 10,
        mainAxisSpacing: 15,
      ),
    );
  }
}
