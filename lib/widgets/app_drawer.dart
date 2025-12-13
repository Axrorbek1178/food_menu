import 'package:flutter/material.dart';

import '../screens/manage_product_screen.dart';
import '../screens/orders_screen.dart';
import '../screens/home_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            automaticallyImplyLeading: false,
            title: const Text("Salom Do'stim"),
          ),
          ListTile(
            leading: const Icon(Icons.shop),
            title: Text("Magazin"),
            onTap: () =>
                Navigator.of(context).pushReplacementNamed(HomeScreen.routName),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.payment),
            title: Text("Buyurtmalar"),
            onTap: () => Navigator.of(
              context,
            ).pushReplacementNamed(OrdersScreen.routName),
          ),
          Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: Text("Mahsulotlarni boshqarish"),
            onTap: () => Navigator.of(
              context,
            ).pushReplacementNamed(ManageProductScreen.routeName),
          ),
        ],
      ),
    );
  }
}
