import 'package:flutter/material.dart';

import '../providers/products.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart';
import '../screens/manage_product_screen.dart';
import '../screens/orders_screen.dart';
import '../screens/cart_screen.dart';
import '../providers/cart.dart';
import './screens/home_screen.dart';
import './screens/product_details_screen.dart';
import './styles/my_shop_style.dart';
import '../noti_service.dart';
import '../providers/auth.dart';
import '../screens/auth_screen.dart';
import '../screens/edit_product_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // init notifications
  NotiService().initNotification();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  ThemeData theme = MyShopStyle.theme;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Auth>(create: (ctx) => Auth()),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (ctx) => Products(),
          update: (ctx, auth, previousProduct) =>
              Products()..setParams(auth.token!),
        ),
        ChangeNotifierProvider<Cart>(create: (ctx) => Cart()),
        ChangeNotifierProvider<Orders>(create: (ctx) => Orders()),
      ],
      child: Consumer<Auth>(
        builder: (BuildContext ctx, authData, Widget? child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: theme,
            home: authData.isAuth ? const HomeScreen() : AuthScreen(),
            routes: {
              HomeScreen.routName: (ctx) => HomeScreen(),
              ProductDetailsScreen.routeName: (ctx) =>
                  const ProductDetailsScreen(),
              CartScreen.routeName: (ctx) => const CartScreen(),
              OrdersScreen.routName: (ctx) => const OrdersScreen(),
              ManageProductScreen.routeName: (ctx) =>
                  const ManageProductScreen(),
              EditProductScreen.routeName: (ctx) => const EditProductScreen(),
            },
          );
        },
      ),
    );
  }
}
