import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart';
import '../screens/orders_screen.dart';
import '../widgets/cart_list_item.dart';
import '../providers/cart.dart';

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
                  OrderButton(cart: cart),
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

class OrderButton extends StatefulWidget {
  const OrderButton({super.key, required this.cart});

  final Cart cart;

  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: (widget.cart.items.isEmpty || _isLoading)
          ? null
          : () async {
              setState(() {
                _isLoading = true;
              });
              await Provider.of<Orders>(context, listen: false).addToOrder(
                widget.cart.items.values.toList(),
                widget.cart.totalPrice,
              );
              setState(() {
                _isLoading = false;
              });
              widget.cart.clearCart();
              Navigator.of(context).pushReplacementNamed(OrdersScreen.routName);
            },
      child: _isLoading
          ? const CircularProgressIndicator.adaptive()
          : const Text("BUYURTMA QILISH"),
    );
  }
}
