import 'package:flutter/material.dart';
import '../packages.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text('Hello you!'),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text('Shop'),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(MainScreen.routeName),
          ),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Orders'),
            onTap: () =>
                Navigator.of(context).pushNamed(OrdersScreen.routeName),
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('User Products'),
            onTap: () =>
                Navigator.of(context).pushNamed(UserProductsScreen.routeName),
          ),
        ],
      ),
    );
  }
}
