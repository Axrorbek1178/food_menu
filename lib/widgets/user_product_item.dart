import 'package:flutter/material.dart';
import 'package:food_menu/providers/products.dart';
import 'package:food_menu/screens/edit_product_screen.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';

class UserProductItem extends StatelessWidget {
  const UserProductItem({super.key});

  void _notifyUserAboutDelete(BuildContext context, Function() removeItem) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text("Ishonchingiz komilmi?"),
          content: const Text(' B mahsulot o\'chmoqda! '),
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
    final product = Provider.of<Product>(context);
    return Card(
      child: ListTile(
        leading: CircleAvatar(backgroundImage: NetworkImage(product.imageUrl)),
        title: Text(product.title),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(
                  context,
                ).pushNamed(EditProductScreen.routeName, arguments: product.id);
              },
              icon: Icon(Icons.edit, color: Theme.of(context).primaryColor),
            ),
            IconButton(
              onPressed: () {
                _notifyUserAboutDelete(context, () {
                  Provider.of<Products>(
                    context,
                    listen: false,
                  ).deleteProduct(product.id);
                });
              },
              icon: Icon(Icons.delete, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
