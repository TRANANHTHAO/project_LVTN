import 'package:appcoffeeshop/Utils.dart';
import 'package:appcoffeeshop/cubit/products/products_cubit.dart';
import 'package:appcoffeeshop/services/auth_service.dart';
import 'package:appcoffeeshop/services/firebase_realtime_service.dart';
import 'package:appcoffeeshop/ui/user_manager/user_manager.dart';
import 'package:appcoffeeshop/ui/user_manager/user_manager_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:appcoffeeshop/ui/cart/cart_manager.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:appcoffeeshop/ui/shared/bottom_navigator_bar.dart';

import 'package:provider/provider.dart';

import 'ui/screens.dart';

Future<void> main() async {
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  AuthService.isAdmin = await Utils.getIsAdmin();
  if (Utils.getUserid() != "") {
    FirebaseRealtimeService().init();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => AuthManager(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => UserManager(),
        ),
        ChangeNotifierProxyProvider<AuthManager, ProductsManager>(
          create: (ctx) => ProductsManager(),
          update: (ctx, authManager, productsManager) {
            productsManager!.authToken = authManager.authToken;
            return productsManager;
          },
        ),
        ChangeNotifierProvider(
          create: (ctx) => CartManager(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => OrdersManager(),
        ),
        BlocProvider(
          create: (context) => ProductsCubit()..init(),
          lazy: false,
        )
      ],
      child: Consumer<AuthManager>(
        builder: (ctx, authManager, child) {
          return MaterialApp(
            title: 'TAT Coffee',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: 'Lato',
              colorScheme: ColorScheme.fromSwatch(
                primarySwatch: Colors.deepOrange,
              ).copyWith(
                secondary: const Color.fromARGB(255, 239, 91, 46),
              ),
            ),
            // home: const BottomNavigator(),
            home: authManager.isAuth
                ? const BottomNavigator()
                : FutureBuilder(
                    future: authManager.tryAutoLogin(),
                    builder: (ctx, snapshot) {
                      return snapshot.connectionState == ConnectionState.waiting
                          ? const SplashScreen()
                          : const AuthScreen();
                    },
                  ),
            routes: {
              OrdersScreen.routeName: (ctx) => const OrdersScreen(),
              UserProductsScreen.routeName: (ctx) => const UserProductsScreen(),
              UserManagerScreen.routeName: (ctx) => const UserManagerScreen(),
              // UserProfilePage.routeName: (ctx) => const UserProfilePage(),
            },
            onGenerateRoute: (settings) {
              if (settings.name == ProductDetailScreen.routeName) {
                final productId = settings.arguments as String;
                return MaterialPageRoute(
                  builder: (ctx) {
                    return ProductDetailScreen(
                      ctx.read<ProductsManager>().findById(productId),
                    );
                  },
                );
              }

              if (settings.name == EditProductScreen.routeName) {
                final productId = settings.arguments as String?;
                return MaterialPageRoute(
                  builder: (ctx) {
                    return EditProductScreen(
                      productId != null
                          ? ctx.read<ProductsManager>().findById(productId)
                          : null,
                    );
                  },
                );
              }

              return null;
            },
          );
        },
      ),
    );
  }
}
