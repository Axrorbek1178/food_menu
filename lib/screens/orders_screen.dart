import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/app_drawer.dart';
import '../providers/orders.dart';
import '../widgets/order_item.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});
  static const routName = "/orders";

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var _isLoading = false;
  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Orders>(context, listen: false).getOrdersFromFirebase().then((
        _,
      ) {
        setState(() {
          _isLoading = false;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(title: Text("BUYURTMALAR")),
      body: orders.items.isEmpty
          ? const Center(child: Text("Buyurtmalar mavjud emas!"))
          : _isLoading
          ? const Center(child: CircularProgressIndicator.adaptive())
          : ListView.builder(
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
