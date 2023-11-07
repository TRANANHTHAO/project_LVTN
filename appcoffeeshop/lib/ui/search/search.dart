import 'package:appcoffeeshop/models/product.dart';
//import 'package:appcoffeeshop/ui/products/product_detail_screen.dart';
import 'package:appcoffeeshop/ui/products/products_manager.dart';
import 'package:appcoffeeshop/ui/search/search_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Search extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      appBarTheme: Theme.of(context).appBarTheme.copyWith(
            toolbarHeight: 90,
            color: const Color.fromARGB(255, 19, 18, 18),
          ),
      //backgroundColor: Colors.orangeAccent,
      textTheme: const TextTheme(
        subtitle1: TextStyle(
          color: Colors.black,
          fontSize: 20.0,
          //fontWeight: FontWeight.bold,
        ),
      ),
      scaffoldBackgroundColor: Colors.white,
      inputDecorationTheme: const InputDecorationTheme(
        contentPadding: EdgeInsets.all(0.5),
        filled: true,
        fillColor: Color.fromARGB(255, 240, 243, 245),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
          borderSide: BorderSide.none,
        ),
      ),
      hintColor: Colors.black,
    );
  }

  @override
  String get searchFieldLabel => 'Nhập tên sản phẩm...';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_sharp),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final products = context.select<ProductsManager, List<Product>>(
        (productsManager) => productsManager.items);
    final productsSearch = products
        .where((element) =>
            element.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: productsSearch.length,
      itemBuilder: (BuildContext context, int index) => Column(
        children: <Widget>[
          SearchListTile(
            productsSearch[index],
          ),
          const Divider(
            height: 12,
            thickness: 1.5,
            color: Colors.black,
          ),
        ],
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final products = context.select<ProductsManager, List<Product>>(
        (productsManager) => productsManager.items);
    final productsSearch = products
        .where((element) =>
            element.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: productsSearch.length,
      itemBuilder: (BuildContext context, int index) => Column(
        children: <Widget>[
          SearchListTile(
            productsSearch[index],
          ),
          // const Divider(
          //   height: 10,
          //   thickness: 1.5,
          //   color: Colors.white,
          // ),
        ],
      ),
    );
  }
}
