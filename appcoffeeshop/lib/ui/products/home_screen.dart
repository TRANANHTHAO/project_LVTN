import 'package:appcoffeeshop/api/api_connection.dart';
import 'package:appcoffeeshop/cubit/products/products_cubit.dart';
import 'package:appcoffeeshop/models/product_type.dart';
import 'package:appcoffeeshop/ui/search/search.dart';
import 'package:chip_list/chip_list.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
//import 'package:http/http.dart';
import 'package:appcoffeeshop/ui/products/products_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

import '../../models/product.dart';
import 'products_grid.dart';
import '../shared/app_drawer.dart';

import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
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
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Color.fromARGB(255, 239, 91, 46),
            ),
            onPressed: () {
              showSearch(
                context: context,
                delegate: Search(),
              );
            },
          ),
        ],
        flexibleSpace: Container(
          color: const Color.fromARGB(255, 19, 18, 18),
        ),
      ),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hey guy!!!!",
                style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w800,
                    fontSize: 20),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "It's a great day to grab a cup of coffee",
                style: TextStyle(color: Colors.blue, fontSize: 14),
              ),
              const SizedBox(
                height: 20,
              ),
              ProductSession(
                title: "Sản phẩm bán chạy",
                content: BlocBuilder<ProductsCubit, ProductsState>(
                    builder: (context, state) {
                  return Container(
                    height: MediaQuery.of(context).size.width * 0.5,
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        return ProductOverviewItem(
                          product: state.allProducts[index],
                        );
                      },
                      separatorBuilder: ((context, index) => const SizedBox(
                            width: 20,
                          )),
                      itemCount: state.allProducts.length,
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.all(10),
                    ),
                  );
                }),
              ),
              const SizedBox(
                height: 20,
              ),
              ProductSession(
                title: "Sản phẩm khuyến mãi",
                content: BlocBuilder<ProductsCubit, ProductsState>(
                    builder: (context, state) {
                  return Container(
                    height: MediaQuery.of(context).size.width * 0.5,
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        return ProductOverviewItem(
                          product: state.allProducts[index],
                        );
                      },
                      separatorBuilder: ((context, index) => const SizedBox(
                            width: 20,
                          )),
                      itemCount: state.allProducts.length,
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.all(10),
                    ),
                  );
                }),
              ),
              const SizedBox(
                height: 20,
              ),
              ProductSession(
                title: "Sản phẩm mới",
                content: BlocBuilder<ProductsCubit, ProductsState>(
                    builder: (context, state) {
                  return Container(
                    height: MediaQuery.of(context).size.width * 0.5,
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        return ProductOverviewItem(
                          product: state.allProducts[index],
                        );
                      },
                      separatorBuilder: ((context, index) => const SizedBox(
                            width: 20,
                          )),
                      itemCount: state.allProducts.length,
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.all(10),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductOverviewItem extends StatelessWidget {
  final Product product;

  const ProductOverviewItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    double _discount = product.getDiscountPrice(context);

    return GestureDetector(
      onTap: () async {
        context.read<ProductsCubit>().init();
      },
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0x00000000).withOpacity(0.05),
                        spreadRadius: 5,
                        blurRadius: 10)
                  ]),
              width: MediaQuery.of(context).size.width * 0.35,
              child: Icon(
                Icons.local_drink_sharp,
                size: 50,
                color: Colors.deepOrange,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.25,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  product.title,
                  style: TextStyle(fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                ),
                Text.rich(
                  TextSpan(
                    text: _discount == 0
                        ? "${product.price} đ"
                        : "${product.getPriceAfterDiscount(_discount)} đ  ",
                    children: [
                      if (_discount != 0)
                        TextSpan(
                          text: "${product.price} đ",
                          style: TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough
                          )
                        )
                    ]
                  ),
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProductSession extends StatelessWidget {
  final String title;
  final Widget content;

  const ProductSession({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
              color: Colors.black87, fontSize: 18, fontWeight: FontWeight.w700),
        ),
        const SizedBox(
          height: 10,
        ),
        content
      ],
    );
  }
}
