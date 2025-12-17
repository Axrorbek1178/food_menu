import 'package:flutter/material.dart';
import 'package:food_menu/screens/edit_product_screen.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';

class UserProductItem extends StatelessWidget {
  const UserProductItem({super.key});

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
              onPressed: () {},
              icon: Icon(Icons.delete, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
