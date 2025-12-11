import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/app_drawer.dart';
import '../providers/orders.dart';
import '../widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});
  static const routName = "/orders";
  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(title: Text("BUYURTMALAR")),
      body: ListView.builder(
        itemCount: orders.items.length,
        itemBuilder: (ctx, i) {
          final order = orders.items[i];
          return OrderItem(
            totalPrice: order.totalPrice,
            date: order.date,
            products: order.products,
          );
        },
      ),
      drawer: const AppDrawer(),
    );
  }
}
