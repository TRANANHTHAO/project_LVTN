import 'package:appcoffeeshop/ui/products/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:appcoffeeshop/ui/products/shopping_cart_icon.dart';

import '../products/favorite_screen.dart';

import '/ui/screens.dart';
//import 'package:provider/provider.dart';

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({super.key});
  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  int selectedIndex = 0;
  final Widget _home = const HomeScreen();
  final Widget _products = const ProductsOverviewScreen();
  final Widget _cart = const CartScreen();
  final Widget _favorite = const FavoriteScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: const Color.fromARGB(255, 19, 18, 18),
          textTheme: Theme.of(context).textTheme.copyWith(
                caption: const TextStyle(color: Colors.black45),
              ),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          selectedItemColor: const Color.fromARGB(255, 236, 62, 9),
          unselectedItemColor: Colors.white,
          items: <BottomNavigationBarItem>[
            const BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: 'Trang Chủ'),
            const BottomNavigationBarItem(
                icon: Icon(Icons.local_drink_outlined),
                activeIcon: Icon(Icons.local_drink),
                label: 'Sản phẩm'),
            BottomNavigationBarItem(
                icon: buildIconShoppingCartBottom(),
                activeIcon: builIcondShoppingCartActive(),
                label: 'Giỏ Hàng'),
            const BottomNavigationBarItem(
                icon: Icon(Icons.favorite_outline),
                activeIcon: Icon(Icons.favorite),
                label: 'Đã Thích'),
          ],
          currentIndex: selectedIndex,
          //selectedItemColor: ,
          onTap: (int index) {
            onTapHandler(index);
          },
        ),
      ),
    );
  }

  getBody() {
    if (selectedIndex == 0) {
      return _home;
    } else if (selectedIndex == 1) {
      return _products;
    } else if (selectedIndex == 2) {
      return _cart;
    } else {
      return _favorite;
    }
  }

  void onTapHandler(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}
