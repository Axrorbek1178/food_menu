import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final String image;
  final String title;
  const ProductItem({super.key, required this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    return GridTile(
      footer: GridTileBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.favorite_outline),
        ),
        trailing: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.shopping_cart),
        ),
        backgroundColor: Colors.black54,
        title: Text(title, textAlign: TextAlign.center),
      ),
      child: Image.network(image, fit: BoxFit.cover),
    );
  }
}
