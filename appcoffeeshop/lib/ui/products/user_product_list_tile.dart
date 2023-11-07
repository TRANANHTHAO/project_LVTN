import 'package:flutter/material.dart';

import '../../models/product.dart';
import 'package:provider/provider.dart';
import 'products_manager.dart';
import 'edit_product_screen.dart';

class UserProductListTile extends StatelessWidget {
  final Product product;

  const UserProductListTile(
    this.product, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.8),
            boxShadow: const [
              BoxShadow(
                blurRadius: 3,
                color: Color.fromARGB(255, 216, 209, 209),
                //offset: Offset(2, 2),
              )
            ],
          ),
          child: ListTile(
            title: Text(
              product.title,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(product.imageUrl),
            ),
            trailing: SizedBox(
              width: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  buildEditButton(context),
                  const Padding(
                    padding: EdgeInsets.all(3),
                  ),
                  buildDeleteButton(context),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildDeleteButton(BuildContext context) {
    return Ink(
      width: 40,
      height: 50,
      padding: const EdgeInsets.all(2),
      child: IconButton(
        icon: const Icon(
          Icons.delete,
          color: Color.fromARGB(255, 250, 17, 0),
        ),
        onPressed: () {
          context.read<ProductsManager>().deleteProduct(product.id!);
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text(
                  'Xóa sản phẩm',
                  textAlign: TextAlign.center,
                ),
              ),
            );
        },
        color: Theme.of(context).errorColor,
      ),
    );
  }

  Widget buildEditButton(BuildContext context) {
    return Ink(
      child: IconButton(
        icon: const Icon(
          Icons.edit,
          color: Color.fromARGB(255, 1, 141, 255),
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(
            EditProductScreen.routeName,
            arguments: product.id,
          );
        },
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
