import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:food_menu/providers/cart.dart';
import 'package:provider/provider.dart';

class CartListItem extends StatelessWidget {
  final String productId;
  final String imageUrl;
  final String title;
  final double price;
  final int quantity;
  const CartListItem({
    super.key,
    required this.productId,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.quantity,
  });

  void _notifyUserAboutDelete(BuildContext context, Function() removeItem) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text("Ishonchingiz komilmi?"),
          content: const Text('Savatchadan bu mahsulotni o\'chimoqda! '),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                "BEKOR QILISH",
                style: TextStyle(color: Colors.black54),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                removeItem();
                Navigator.pop(context);
              },
              child: Text('O\'CHIRISH', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    return Slidable(
      endActionPane: ActionPane(
        extentRatio: 0.3,
        motion: const ScrollMotion(),
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
              backgroundColor: Colors.red,
            ),
            onPressed: () => _notifyUserAboutDelete(
              context,
              () => cart.removeItem(productId),
            ),
            child: const Text(
              "O'chirish",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
      key: ValueKey(productId),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: ListTile(
          leading: CircleAvatar(backgroundImage: NetworkImage(imageUrl)),
          title: Text(title),
          subtitle: Text("Umumiy: \$${(price * quantity).toStringAsFixed(2)}"),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () => cart.removeSingleItem(productId),
                icon: const Icon(Icons.remove, color: Colors.black),
              ),
              Container(
                alignment: .center,
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade200,
                ),
                child: Text("$quantity"),
              ),
              IconButton(
                onPressed: () =>
                    cart.addToCart(productId, title, imageUrl, price),
                icon: const Icon(Icons.add, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
