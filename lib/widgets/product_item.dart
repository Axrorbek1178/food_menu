import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../models/product.dart';
import '../screens/product_details_screen.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GestureDetector(
        onTap: () {
          Navigator.of(
            context,
          ).pushNamed(ProductDetailsScreen.routeName, arguments: product.id);
        },
        child: GridTile(
          footer: GridTileBar(
            leading: Consumer<Product>(
              builder: (ctx, pro, child) {
                return IconButton(
                  onPressed: () {
                    pro.toggleFavorite();
                  },
                  icon: Icon(
                    pro.isFavorite ? Icons.favorite : Icons.favorite_outline,
                    color: Theme.of(context).primaryColor,
                  ),
                );
              },
            ),
            trailing: IconButton(
              onPressed: () {
                cart.addToCart(
                  product.id,
                  product.title,
                  product.imageUrl,
                  product.price,
                );
              },
              icon: Icon(
                Icons.shopping_cart,
                color: Theme.of(context).primaryColor,
              ),
            ),
            backgroundColor: Colors.black87,
            title: Text(product.title, textAlign: TextAlign.center),
          ),
          child: Image.network(product.imageUrl, fit: BoxFit.cover),
        ),
      ),
    );
  }
}
