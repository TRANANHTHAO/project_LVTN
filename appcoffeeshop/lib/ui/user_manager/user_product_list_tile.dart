import 'package:appcoffeeshop/models/user_model.dart';
import 'package:appcoffeeshop/ui/user_manager/user_manager.dart';
import 'package:flutter/material.dart';

//import '../../models/product.dart';
import 'package:provider/provider.dart';

class UserListTile extends StatelessWidget {
  final UserModel userModel;

  const UserListTile(
    this.userModel, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color.fromARGB(255, 96, 48, 3),
            boxShadow: const [
              BoxShadow(
                blurRadius: 10,
                color: Colors.black,
                //offset: Offset(2, 2),
              )
            ],
          ),
          child: ListTile(
            title: Text(
              userModel.email ?? '',
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            trailing: SizedBox(
              width: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
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
          context.read<UserManager>().deleteUser(userModel.id!);
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text(
                  'Xóa người dùng',
                  textAlign: TextAlign.center,
                ),
              ),
            );
        },
        color: Theme.of(context).errorColor,
      ),
    );
  }
}
