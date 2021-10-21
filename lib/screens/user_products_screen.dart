import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../packages.dart';

class UserProductsScreen extends StatefulWidget {
  static const routeName = '/user_products';

  @override
  State<UserProductsScreen> createState() => _UserProductsScreenState();
}

class _UserProductsScreenState extends State<UserProductsScreen> {
  Future? _productsFuture;

  Future<void> _refreshProducts() async {
    await Provider.of<Products>(context, listen: false)
        .fetchAndSetProducts(true);
  }

  @override
  void initState() {
    _productsFuture = _refreshProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
      body: FutureBuilder(
        future: _productsFuture,
        builder: (_, snapshot) => RefreshIndicator(
          onRefresh: () => _refreshProducts(),
          child: Consumer<Products>(
            builder: (_, products, ch) => Padding(
              padding: const EdgeInsets.all(8),
              child: snapshot.connectionState == ConnectionState.waiting
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemBuilder: (_, index) => ChangeNotifierProvider.value(
                        value: products.getItems[index],
                        child: Column(
                          children: [
                            UserProductItem(products.getItems[index]),
                            const Divider(
                              thickness: 1.5,
                            ),
                          ],
                        ),
                      ),
                      itemCount: products.getItems.length,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
