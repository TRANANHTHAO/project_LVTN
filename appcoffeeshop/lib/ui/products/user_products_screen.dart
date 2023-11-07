import 'package:flutter/material.dart';
import 'package:appcoffeeshop/ui/products/products_manager.dart';

import 'user_product_list_tile.dart';

import '../shared/app_drawer.dart';

import 'package:provider/provider.dart';
import 'edit_product_screen.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';
  const UserProductsScreen({super.key});

  Future<void> _refreshProducts(BuildContext context) async {
    await context.read<ProductsManager>().fetchProducts(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
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
        title: const Text('Quản Lý Sản Phẩm'),
        flexibleSpace: Container(
          color: const Color.fromARGB(255, 19, 18, 18),
        ),
      ),
      drawer: const AppDrawer(),
      body: FutureBuilder(
        future: _refreshProducts(context),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return RefreshIndicator(
            onRefresh: () => _refreshProducts(context),
            child: buildUserProductListView(),
          );
        },
      ),
      floatingActionButton: buildAddButton(context),
    );
  }

  Widget buildUserProductListView() {
    return Consumer<ProductsManager>(
      builder: (ctx, productsManager, child) {
        return Padding(
          padding: const EdgeInsets.all(15),
          child: ListView.builder(
            itemCount: productsManager.itemCount,
            itemBuilder: (ctx, i) => Column(
              children: <Widget>[
                UserProductListTile(
                  productsManager.items[i],
                ),
                const Divider(
                  height: 25,
                  thickness: 1.5,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildAddButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context).pushNamed(
          EditProductScreen.routeName,
        );
      },
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }
}
