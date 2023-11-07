import 'package:flutter/material.dart';

import 'products_grid.dart';

//enum FilterOptions { favorites, all }

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 105,
        leadingWidth: 30,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/');
          },
        ),
        title: const Text(
          'Sản Phẩm Yêu Thích',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'Lato',
          ),
        ),
        flexibleSpace: Container(
          color: const Color.fromARGB(255, 19, 18, 18),
        ),
        centerTitle: false,
      ),
      body: const ProductsGrid(true),
    );
  }
}
