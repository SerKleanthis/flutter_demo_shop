import 'package:flutter/material.dart';
import '../packages.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Hello you!'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Shop'),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(MainScreen.routeName),
          ),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Orders'),
            onTap: () =>
                Navigator.of(context).pushNamed(OrdersScreen.routeName),
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('User Products'),
            onTap: () =>
                Navigator.of(context).pushNamed(UserProductsScreen.routeName),
          ),
        ],
      ),
    );
  }
}
