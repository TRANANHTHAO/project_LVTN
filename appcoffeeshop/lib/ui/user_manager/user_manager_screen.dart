import 'package:appcoffeeshop/ui/user_manager/user_manager.dart';
import 'package:appcoffeeshop/ui/user_manager/user_product_list_tile.dart';
import 'package:flutter/material.dart';
// import 'package:appcoffeeshop/ui/products/products_manager.dart';

// import '../products/edit_product_screen.dart';
// import '../products/user_product_list_tile.dart';
import '../shared/app_drawer.dart';

import 'package:provider/provider.dart';

class UserManagerScreen extends StatelessWidget {
  static const routeName = '/user-manager';
  const UserManagerScreen({super.key});

  Future<void> _refreshProducts(BuildContext context) async {
    await context.read<UserManager>().fetchUser();
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
        title: const Text('Quản Lý người dùng'),
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
            child: buildUserListView(),
          );
        },
      ),
    );
  }

  Widget buildUserListView() {
    return Consumer<UserManager>(
      builder: (ctx, productsManager, child) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: ListView.builder(
            itemCount: productsManager.users.length,
            itemBuilder: (ctx, i) => Column(
              children: <Widget>[
                UserListTile(
                  productsManager.users[i],
                ),
                const Divider(
                  height: 35,
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
}
