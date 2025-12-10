import 'package:flutter/material.dart';
import 'package:food_menu/widgets/cart_list_item.dart';
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
      body: Column(
        children: [
          Card(
            margin: const EdgeInsetsGeometry.all(10),
            child: Padding(
              padding: const EdgeInsetsGeometry.all(10),
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
                  TextButton(onPressed: () {}, child: Text("Buyurtma qilish")),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (ctx, i) {
                final cartItem = cart.items.values.toList()[i];
                return CartListItem(
                  productId: cart.items.keys.toList()[i],
                  imageUrl: cartItem.image,
                  title: cartItem.title,
                  price: cartItem.price,
                  quantity: cartItem.quantity,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
