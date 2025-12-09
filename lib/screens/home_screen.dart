import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../providers/products.dart';
import '../widgets/custom_cart.dart';
import '../widgets/products_grid.dart';

enum FiltersOtions { Favorites, All }

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mening Do\'konim'),
        actions: [
          PopupMenuButton(
            onSelected: (FiltersOtions filter) {
              if (filter == FiltersOtions.All) {
                //..barchasiniP ko'rsat
                productData.showAll();
              } else {
                //..sevimlilarni ko'rsat
                productData.showFavorites();
              }
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
              onPressed: () {},
              icon: const Icon(Icons.shopping_cart),
            ),
          ),
        ],
      ),
      body: const ProductsGrid(),
    );
  }
}
