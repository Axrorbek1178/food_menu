import 'package:flutter/material.dart';
import 'package:food_menu/models/cart_item.dart';
import 'package:intl/intl.dart';

class OrderItem extends StatefulWidget {
  final double totalPrice;
  final DateTime date;
  final List<CartItem> products;
  const OrderItem({
    super.key,
    required this.totalPrice,
    required this.date,
    required this.products,
  });

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool _expandItem = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Column(
        children: [
          ListTile(
            title: Text("\$${widget.totalPrice}"),
            subtitle: Text(DateFormat("dd/MM/yyyy hh:mm").format(widget.date)),
            trailing: IconButton(
              onPressed: () {
                setState(() {
                  _expandItem = !_expandItem;
                });
              },
              icon: Icon(_expandItem ? Icons.expand_more : Icons.expand_less),
            ),
          ),
          if (_expandItem)
            Container(
              height: 100,
              child: ListView.builder(
                itemCount: widget.products.length,
                itemBuilder: (ctx, i) {
                  final product = widget.products[i];
                  return ListTile(
                    title: Text(product.title),
                    trailing: Text("${product.quantity}x \$${product.price}"),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
