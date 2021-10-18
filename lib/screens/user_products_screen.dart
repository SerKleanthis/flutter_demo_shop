import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../packages.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user_products';
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context).getItems;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context)
                .pushNamed(EditProductScreen.routeName, arguments: null),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemBuilder: (_, index) => ChangeNotifierProvider.value(
            value: products[index],
            child: Column(
              children: [
                UserProductItem(products[index]),
                const Divider(
                  thickness: 1.5,
                ),
              ],
            ),
          ),
          itemCount: products.length,
        ),
      ),
    );
  }
}
