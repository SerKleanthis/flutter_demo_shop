import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../packages.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  Future? _ordersFuture;

  @override
  void initState() {
    _ordersFuture = _obtainFuture();
    super.initState();
  }

  Future _obtainFuture() {
    return Provider.of<Orders>(context, listen: false).fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    final token = Provider.of<Auth>(context).getToken;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Orders'),
        ),
        drawer: AppDrawer(),
        body: FutureBuilder(
          future: _ordersFuture,
          builder: (_, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (dataSnapshot.hasError) {
              return const Center(child: Text('Error'));
            } else {
              return Consumer<Orders>(
                builder: (_, orders, ch) => ListView.builder(
                  itemBuilder: (_, index) {
                    return OrderItemWidget(orders.getOrders[index]);
                  },
                  itemCount: orders.getOrders.length,
                ),
              );
            }
          },
        ));
  }
}
