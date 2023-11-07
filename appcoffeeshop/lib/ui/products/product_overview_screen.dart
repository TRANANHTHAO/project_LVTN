import 'package:appcoffeeshop/cubit/products/products_cubit.dart';
import 'package:appcoffeeshop/models/product_type.dart';
import 'package:appcoffeeshop/ui/search/search.dart';
import 'package:chip_list/chip_list.dart';

import 'package:flutter/material.dart';
//import 'package:http/http.dart';
import 'package:appcoffeeshop/ui/products/products_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/product.dart';
import 'products_grid.dart';
import '../shared/app_drawer.dart';

import 'package:provider/provider.dart';

enum FilterOptions { favorites, all }

class ProductsOverviewScreen extends StatefulWidget {
  static String routeName = "/ProductsOverviewScreen";
  const ProductsOverviewScreen({super.key});

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  final _showOnlyFavorites = ValueNotifier<bool>(false);
  late Future<void> _fetchProducts;
  int _currentIndex = 0;
  late List<Product> _currentProducts;

  @override
  void initState() {
    super.initState();
    _fetchProducts = context.read<ProductsManager>().fetchProducts();
    _currentProducts = context.read<ProductsCubit>().getProductsByType(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.black,
      // backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        toolbarHeight: 105,
        leadingWidth: 50,
        title: const Text(
          'TAT Coffee',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        // actions: [
        //   IconButton(
        //     icon: const Icon(
        //       Icons.search,
        //       color: Color.fromARGB(255, 239, 91, 46),
        //     ),
        //     onPressed: () {
        //       showSearch(
        //         context: context,
        //         delegate: Search(),
        //       );
        //     },
        //   ),
        // ],
        flexibleSpace: Container(
          color: const Color.fromARGB(255, 19, 18, 18),
        ),
      ),
      // drawer: const AppDrawer(),
      body:
          BlocBuilder<ProductsCubit, ProductsState>(builder: (context, state) {
        return Column(
          children: [
            ChipList(
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
              inactiveTextColorList: const [
                Colors.black,
              ],
              activeBgColorList: const [
                Color.fromARGB(255, 239, 91, 46),
              ],
              activeTextColorList: [
                const Color.fromARGB(255, 0, 0, 0).withOpacity(0.8),
              ],
              listOfChipNames: state.categories.map((e) => e.tenloai).toList(),
              listOfChipIndicesCurrentlySeclected: [_currentIndex],
              extraOnToggle: (val) async {
                _currentIndex = val;
                _currentProducts =
                    context.read<ProductsCubit>().getProductsByType(val + 1);
                setState(() {});
              },
            ),
            Expanded(
                child: ValueListenableBuilder<bool>(
              valueListenable: _showOnlyFavorites,
              builder: (context, onlyFavorites, child) {
                return ProductsGrid(
                  onlyFavorites,
                  products: _currentProducts,
                );
              },
            ))
          ],
        );
      }),
    );
  }
}
