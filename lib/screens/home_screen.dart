import 'package:flutter/material.dart';
import 'package:food_menu/widgets/products_grid.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mening Do\'konim')),
      body: const ProductsGrid(),
    );
  }
}
