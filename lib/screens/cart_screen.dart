import 'package:flutter/material.dart';
import '../providers/cart.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  static const routeName = '/cart';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Sizning Savatchangiz")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: EdgeInsetsGeometry.all(10),
                child: Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Text('Umumiy:', style: const TextStyle(fontSize: 16)),
                    Spacer(),
                    Chip(
                      label: Text(
                        "\$ ${cart.totalPrice.toStringAsFixed(2)}",
                        style: const TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text("Buyurtma qilish"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
