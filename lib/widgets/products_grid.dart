import 'package:flutter/material.dart';
import 'package:food_menu/models/product.dart';
import '../providers/products.dart';
import '../widgets/product_item.dart';
import 'package:provider/provider.dart';

class ProductsGrid extends StatefulWidget {
  final bool showFavorites;
  const ProductsGrid(this.showFavorites, {super.key});

  @override
  State<ProductsGrid> createState() => _ProductsGridState();
}

class _ProductsGridState extends State<ProductsGrid> {
  late Future _productsFuture;

  Future _getProductsFuture() {
    return Provider.of<Products>(
      context,
      listen: false,
    ).getProductsFromFirebase();
  }

  @override
  void initState() {
    _productsFuture = _getProductsFuture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _productsFuture,
      builder: (ctx, dataSnapshot) {
        if (dataSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator.adaptive());
        } else {
          if (dataSnapshot.error == null) {
            return Consumer<Products>(
              builder: (c, products, child) {
                final ps = widget.showFavorites
                    ? products.favorites
                    : products.list;
                return ps.isNotEmpty
                    ? GridView.builder(
                        padding: const EdgeInsets.all(20),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              childAspectRatio: 3 / 2,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20,
                            ),
                        itemCount: ps.length,
                        itemBuilder: (ctx, index) {
                          return ChangeNotifierProvider<Product>.value(
                            value: ps[index],
                            child: const ProductItem(),
                          );
                        },
                      )
                    : Center(child: Text("Hozircha maxsulotlar mavjud emas"));
              },
            );
          } else {
            //.. xatolik
            return const Center(child: Text("Xatolik sodir bo'ldi"));
          }
        }
      },
    );
  }
}
