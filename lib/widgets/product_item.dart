import 'package:flutter/material.dart';
import 'package:food_menu/screens/product_details_screen.dart';

class ProductItem extends StatelessWidget {
  final String productId;
  final String image;
  final String title;
  const ProductItem({
    super.key,
    required this.image,
    required this.title,
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GestureDetector(
        onTap: () {
          Navigator.of(
            context,
          ).pushNamed(ProductDetailsScreen.routeName, arguments: productId);
        },
        child: GridTile(
          footer: GridTileBar(
            leading: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.favorite_outline,
                color: Theme.of(context).primaryColor,
              ),
            ),
            trailing: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.shopping_cart,
                color: Theme.of(context).primaryColor,
              ),
            ),
            backgroundColor: Colors.black87,
            title: Text(title, textAlign: TextAlign.center),
          ),
          child: Image.network(image, fit: BoxFit.cover),
        ),
      ),
    );
  }
}
