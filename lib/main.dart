import 'package:flutter/material.dart';
import 'package:food_menu/providers/products.dart';
import 'package:provider/provider.dart';
import './screens/home_screen.dart';
import './screens/product_details_screen.dart';
import './styles/my_shop_style.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  ThemeData theme = MyShopStyle.theme;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Products>(
      create: (ctx) {
        return Products();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme,
        home: HomeScreen(),
        routes: {
          ProductDetailsScreen.routeName: (ctx) => const ProductDetailsScreen(),
        },
      ),
    );
  }
}
