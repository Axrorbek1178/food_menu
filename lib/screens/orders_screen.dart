import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});
  static const routName = "/orders";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("BUYURTMALAR")),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile();
        },
      ),
      drawer: const AppDrawer(),
    );
  }
}
