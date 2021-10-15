import 'package:flutter/material.dart';
import 'package:flutter_demo_shop/widgets/drawer.dart';
import 'package:provider/provider.dart';
import '../packages.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';
  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Orders>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return OrderItemWidget(orders.getOrders[index]);
        },
        itemCount: orders.getOrders.length,
      ),
    );
  }
}
