import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../packages.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  const Spacer(),
                  Chip(
                    label: Text('${cart.getTotalAmount.toStringAsFixed(2)} \$'),
                    backgroundColor: Theme.of(context).backgroundColor,
                  ),
                  TextButton(
                    onPressed: () {
                      Provider.of<Orders>(context, listen: false).addOrder(
                          cart.getItems.values.toList(), cart.getTotalAmount);
                      cart.clearCart();
                    },
                    child: const Text('Order Now!'),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
              child: ListView.builder(
            itemBuilder: (ctx, index) =>
                CartItemWidget(cart.getItems.values.toList()[index]),
            itemCount: cart.getItems.length,
          ))
        ],
      ),
    );
  }
}
