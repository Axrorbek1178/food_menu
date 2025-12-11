import 'package:flutter/material.dart';
import '../screens/cart_screen.dart';
import '../widgets/app_drawer.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../widgets/custom_cart.dart';
import '../widgets/products_grid.dart';

enum FiltersOtions { Favorites, All }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const routName = '/';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _showOnlyFavorites = false;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mening Do\'konim'),
        actions: [
          PopupMenuButton(
            onSelected: (FiltersOtions filter) {
              setState(() {
                if (filter == FiltersOtions.All) {
                  //..barchasiniP ko'rsat
                  _showOnlyFavorites = false;
                } else {
                  //..sevimlilarni ko'rsat
                  _showOnlyFavorites = true;
                }
              });
            },
            itemBuilder: (ctx) {
              return [
                PopupMenuItem(
                  value: FiltersOtions.All,
                  child: Text("Barchasi"),
                ),
                PopupMenuItem(
                  value: FiltersOtions.Favorites,
                  child: Text("Sevimli"),
                ),
              ];
            },
          ),
          Consumer<Cart>(
            builder: (ctx, cart, child) {
              return CustomCart(
                number: cart.itemsCount().toString(),
                child: child!,
              );
            },
            child: IconButton(
              onPressed: () =>
                  Navigator.pushNamed(context, CartScreen.routeName),
              icon: const Icon(Icons.shopping_cart),
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: ProductsGrid(_showOnlyFavorites),
    );
  }
}
