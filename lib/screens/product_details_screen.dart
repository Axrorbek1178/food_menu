import 'package:flutter/material.dart';
import 'package:food_menu/providers/cart.dart';
import 'package:food_menu/screens/cart_screen.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  static const routeName = '/product-details';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments;
    final product = Provider.of<Products>(
      context,
      listen: false,
    ).findById(productId as String);

    return Scaffold(
      appBar: AppBar(title: Text(product.title)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 300,
              child: Image.network(product.imageUrl, fit: .cover),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(product.description),
            ),
          ],
        ),
      ),
      bottomSheet: BottomAppBar(
        child: Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            Column(
              mainAxisAlignment: .center,
              crossAxisAlignment: .start,
              children: [
                const Text(
                  "Narxi:",
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                Text(
                  "\$${product.price}",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Consumer<Cart>(
              builder: (ctx, cart, child) {
                final isProductAdded = cart.items.containsKey(productId);
                if (isProductAdded) {
                  return ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 12,
                      ),
                      backgroundColor: Colors.grey.shade300,
                      shape: RoundedSuperellipseBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0,
                    ),
                    onPressed: () =>
                        Navigator.pushNamed(context, CartScreen.routeName),
                    icon: Icon(
                      Icons.shopping_bag_outlined,
                      color: Colors.black,
                    ),
                    label: const Text(
                      "Savatchaga borish",
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                } else {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 12,
                      ),
                      backgroundColor: Colors.black,
                      shape: RoundedSuperellipseBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () => cart.addToCart(
                      productId,
                      product.title,
                      product.imageUrl,
                      product.price,
                    ),
                    child: const Text(
                      "Savatchaga qo'shish",
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
