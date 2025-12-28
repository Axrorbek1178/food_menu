import 'package:flutter/material.dart';
import 'package:food_menu/screens/edit_product_screen.dart';
import 'package:food_menu/widgets/app_drawer.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../widgets/user_product_item.dart';

class ManageProductScreen extends StatelessWidget {
  const ManageProductScreen({super.key});

  static const routeName = "/manage-products";

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(
      context,
      listen: false,
    ).getProductsFromFirebase(true);
  }

  @override
  Widget build(BuildContext context) {
    // final productProvider = Provider.of<Products>(context);
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
      body: FutureBuilder(
        future: _refreshProducts(context),
        builder: (ctx, snapshotData) {
          if (snapshotData.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else if (snapshotData.connectionState == ConnectionState.done) {
            return RefreshIndicator(
              onRefresh: () => _refreshProducts(context),
              child: Consumer<Products>(
                builder: (c, productsProvider, _) {
                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: productsProvider.list.length,
                    itemBuilder: (ctx, i) {
                      final product = productsProvider.list[i];
                      return ChangeNotifierProvider.value(
                        value: product,
                        child: const UserProductItem(),
                      );
                    },
                  );
                },
              ),
            );
          } else {
            return const Center(child: Text('Xatolik sodir bo\'ldi...'));
          }
        },
      ),
    );
  }
}
