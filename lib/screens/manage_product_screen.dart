import 'package:flutter/material.dart';
import 'package:food_menu/screens/edit_product_screen.dart';
import 'package:food_menu/widgets/app_drawer.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../widgets/user_product_item.dart';

class ManageProductScreen extends StatelessWidget {
  const ManageProductScreen({super.key});

  static const routeName = "/manage-products";

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(EditProductScreen.routeName),
            icon: const Icon(Icons.add),
          ),
        ],
        title: Text("Mahsulotlarni boshqarish"),
      ),
      drawer: const AppDrawer(),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: productProvider.list.length,
        itemBuilder: (ctx, i) {
          final product = productProvider.list[i];
          return ChangeNotifierProvider.value(
            value: product,
            child: const UserProductItem(),
          );
        },
      ),
    );
  }
}
