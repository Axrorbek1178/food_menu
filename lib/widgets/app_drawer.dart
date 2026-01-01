import 'package:flutter/material.dart';
import 'package:food_menu/providers/auth.dart';
import 'package:provider/provider.dart';

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
            title: const Text("Magazin"),
            onTap: () =>
                Navigator.of(context).pushReplacementNamed(HomeScreen.routName),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text("Buyurtmalar"),
            onTap: () => Navigator.of(
              context,
            ).pushReplacementNamed(OrdersScreen.routName),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("Mahsulotlarni boshqarish"),
            onTap: () => Navigator.of(
              context,
            ).pushReplacementNamed(ManageProductScreen.routeName),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text("Chiqish"),
            onTap: () => Provider.of<Auth>(context, listen: false).logout(),
          ),
        ],
      ),
    );
  }
}
