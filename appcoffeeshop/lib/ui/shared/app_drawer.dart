import 'package:appcoffeeshop/Utils.dart';
import 'package:appcoffeeshop/services/auth_service.dart';
import 'package:appcoffeeshop/ui/user_manager/user_manager_screen.dart';
import 'package:flutter/material.dart';

import '../orders/orders_screen.dart';

import '../products/user_products_screen.dart';

import 'package:provider/provider.dart';
import '../auth/auth_manager.dart';

class AppDrawer extends StatelessWidget {
  //final User user;
  const AppDrawer({
    super.key, //required this.user,
  });

  //String userName = '';

  @override
  Widget build(BuildContext context) {
    return Drawer(
      //backgroundColor: const Color.fromARGB(255, 1, 18, 32),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        color: const Color.fromARGB(255, 19, 18, 18),
        child: SafeArea(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,

            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              GestureDetector(
                // onTap: () {
                //   Navigator.push(context, MaterialPageRoute(builder: (_) => const UserProfilePage()))
                // },
                child: UserAccountsDrawerHeader(
                  arrowColor: Colors.white,
                  //arrowColor: Colors.white,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ-PBK0d59ELecLfQJWnvdYYUutp5dU044a1g&usqp=CAU'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  currentAccountPicture: const CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://polis.pontianak.go.id/admin/img/user.png'),
                    //backgroundColor: Color.fromARGB(255, 246, 219, 197),
                  ),
                  accountEmail: FutureBuilder(
                    future: Utils.getEmailUser(),
                    builder: (ctx, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {

                        return const Text(
                          // snapshot.data,
                          "email",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                  accountName: Text("ho viet phat"),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                leading: const Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                title: const Text(
                  'Trang Chủ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pushReplacementNamed('/');
                },
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                leading: const Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                ),
                title: const Text(
                  'Quản Lý Đơn Hàng',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                onTap: () {
                  Navigator.of(context)
                      .pushReplacementNamed(OrdersScreen.routeName);
                },
              ),
              const SizedBox(
                height: 10,
              ),
              if (AuthService.isAdmin)
                ListTile(
                  leading: const Icon(
                    Icons.shopping_bag,
                    color: Colors.white,
                  ),
                  title: const Text('Quản Lý Sản Phẩm',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      )),
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacementNamed(UserProductsScreen.routeName);
                  },
                ),
              if (AuthService.isAdmin)
                ListTile(
                  leading: const Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  title: const Text('Quản Lý người dùng',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      )),
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacementNamed(UserManagerScreen.routeName);
                  },
                ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                color: Colors.white,
                thickness: 2,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Thiết Lập',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  //letterSpacing: 3,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                leading: const Icon(
                  Icons.exit_to_app,
                  color: Color.fromARGB(255, 255, 22, 5),
                ),
                title: const Text(
                  'Đăng Xuất',
                  style: TextStyle(
                    color: Color.fromARGB(255, 235, 17, 1),
                    fontSize: 18,
                  ),
                ),
                onTap: () {
                  Navigator.of(context)
                    ..pop()
                    ..pushReplacementNamed('/');
                  context.read<AuthManager>().logout();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
