import 'package:flutter/material.dart';
import 'package:food_menu/models/product.dart';
import 'package:food_menu/widgets/product_item.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<Product> _products = [
    Product(
      id: 'p1',
      title: 'Macbook Pro',
      description: 'Macbook Pro 2026',
      price: 3.99,
      imageUrl:
          'https://images.unsplash.com/photo-1592919933511-ea9d487c85e4?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    ),
    Product(
      id: 'p2',
      title: 'Airpods',
      description: 'Apple Airpods',
      price: 2.49,
      imageUrl:
          'https://images.unsplash.com/photo-1603351154351-5e2d0600bb77?q=80&w=2071&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mening Do\'konim')),
      body: GridView.builder(
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        itemCount: _products.length,
        itemBuilder: (ctx, index) {
          return ProductItem(
            image: _products[index].imageUrl,
            title: _products[index].title,
          );
        },
      ),
    );
  }
}
