import 'package:appcoffeeshop/ui/products/size_picker_btm_sheet.dart';
import 'package:flutter/material.dart';
import 'package:appcoffeeshop/ui/products/shopping_cart_icon.dart';

import '../../models/product.dart';
import '../cart/cart_manager.dart';
import '../screens.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';

  const ProductDetailScreen(
    this.product, {
    super.key,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartManager>();
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        toolbarHeight: 70,
        leadingWidth: 30,
        title: Text(
          product.title,
          style: const TextStyle(
            fontSize: 22,
            wordSpacing: 4,
            fontWeight: FontWeight.bold,
            fontFamily: 'Lato',
            letterSpacing: 2,
          ),
        ),
        actions: <Widget>[
          Ink(
            //padding: EdgeInsetsGeometry.infinity,
            width: 40,
            height: 40,

            // child: buildIconShoppingCart(),
          ),
        ],
        flexibleSpace: Container(
          color: const Color.fromARGB(255, 19, 18, 18),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Container(
                height: 230,
                width: 230,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(product.imageUrl),
                  ),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 20,
                      color: Color.fromARGB(255, 88, 87, 87),
                      offset: Offset(2, 2),
                    )
                  ],
                ),
                child: ValueListenableBuilder<bool>(
                  valueListenable: product.isFavoriteListenable,
                  builder: (ctx, isFavorite, child) {
                    return IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: const Color.fromARGB(255, 189, 69, 0),
                        size: 25,
                      ),
                      alignment: Alignment.topRight,
                      padding: const EdgeInsets.all(10.0),
                      color: Theme.of(context).colorScheme.secondary,
                      onPressed: () {
                        // ctx
                        //     .read<ProductsManager>()
                        //     .toggleFavoriteStatus(product);
                      },
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      product.title,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 3,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Giá: ${product.price}00 VND',
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 18,
                        //fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 19, 18, 18),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 10,
                      color: Colors.black,
                      offset: Offset(2, 2),
                    )
                  ],
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 75, vertical: 8.0),
                child: const Text(
                  'Mô tả chi tiết sản phẩm ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Lato',
                    color: Colors.white,
                    fontSize: 17,
                  ),
                  //softWrap: true,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                child: Text(
                  product.description,
                  textAlign: TextAlign.justify,
                  softWrap: true,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 7, 7, 7),
                    fontSize: 16,
                  ),
                  textScaleFactor: 1.05,
                ),
              ),
              _buildInputComments(context),
              const SizedBox(
                height: 10,
              ),
              _buildCommentContentArea(context)
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 55,
          width: 200,
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildAddToCartButton(context),
              _buildOrderButton(cart, context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddToCartButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 184, 67, 0),
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(20),
        // ),
      ),
      onPressed: () {
        showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          builder: (c) => Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16),
                    topLeft: Radius.circular(16))),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizePickerBottomSheet(
              onConfirm: (size) {
                Navigator.pop(context);
                size;
                final cart = context.read<CartManager>();
                cart.addItem(product);
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: const Text(
                        'Sản phẩm được thêm vào giỏ hàng',
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
            ),
          ),
        );
      },
      child: const SizedBox(
        height: 30,
        child: Text(
          'Thêm vào giỏ',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  TextButton _buildOrderButton(CartManager cart, BuildContext context) {
    return TextButton(
      onPressed: cart.totalAmount <= 0
          ? null
          : () {
              context.read<OrdersManager>().showBottomSheet(
                    context,
                    cart.products,
                    cart.totalAmount,
                    () => cart.clear(),
                  );
            },
      style: TextButton.styleFrom(
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(20),
        // ),
        padding: const EdgeInsets.symmetric(
          horizontal: 35.0,
        ),
        backgroundColor: const Color.fromARGB(255, 0, 63, 114),
      ),
      child: const Text(
        'ĐẶT HÀNG',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          letterSpacing: 3,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildCommentContentArea(BuildContext context) {
    return FutureBuilder(
      future: context.read<ProductsManager>().fetchComment(product.id!),
      builder: (ctx, snapshot) {
        return snapshot.connectionState == ConnectionState.done
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Đánh giá sản phẩm",
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const CustomRatingBar(),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "(${context.read<ProductsManager>().itemCountComment} lượt bình luận)",
                        style: TextStyle(color: Colors.black45, fontSize: 12),
                      )
                    ],
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: context.read<ProductsManager>().itemCountComment,
                    itemBuilder: (ctx, i) => Row(
                      children: [
                        Expanded(
                          child: Container(
                            //alignment: Alignment.center,
                            padding: const EdgeInsets.all(15),
                            child: Text(
                              "\u2022 " +
                                  context.read<ProductsManager>().comments[i],
                              style: TextStyle(color: Colors.black87),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              )
            : const SizedBox(
                height: 5,
              );
      },
    );
  }

  Widget _buildInputComments(BuildContext context) {
    var controller = TextEditingController();
    var comment = '';
    return Row(
      //mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Flexible(
          child: TextFormField(
            controller: controller,
            //cursorColor: const Color.fromARGB(255, 15, 15, 15),
            decoration: const InputDecoration(
              labelText: 'Bình luận của bạn',
              labelStyle: TextStyle(
                color: Colors.deepOrangeAccent,
              ),
              icon: Icon(
                Icons.comment,
                color: Colors.deepOrangeAccent,
              ),
            ),
            keyboardType: TextInputType.text,
            validator: (value) {},
            onChanged: (value) {
              comment = value;
            },
          ),
        ),
        TextButton(
          onPressed: () {
            print(comment);
            context.read<ProductsManager>().addComment(
                  product,
                  comment,
                );
            controller.text = '';
          },
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 15.0,
            ),
            backgroundColor: const Color.fromARGB(255, 0, 63, 114),
          ),
          child: const Text(
            'Thêm',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}

class CustomRatingBar extends StatefulWidget {
  const CustomRatingBar({
    super.key,
  });

  @override
  State<CustomRatingBar> createState() => _CustomRatingBarState();
}

class _CustomRatingBarState extends State<CustomRatingBar> {
  late double _rating;

  @override
  void initState() {
    super.initState();
    _rating = 1.0;
  }

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: _rating,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      unratedColor: Colors.amber.withAlpha(70),
      itemCount: 5,
      itemSize: 30.0,
      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {
        setState(() {
          _rating = rating;
        });
      },
      updateOnDrag: true,
    );
  }
}
