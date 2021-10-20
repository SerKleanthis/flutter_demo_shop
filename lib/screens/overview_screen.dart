import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../packages.dart';

enum FilterOptions { favorites, all }

class MainScreen extends StatefulWidget {
  static const String routeName = '/';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Future? _productsFuture;

  @override
  void initState() {
    _productsFuture = _obtainFuture();
    super.initState();
  }

  Future _obtainFuture() {
    return Provider.of<Products>(context, listen: false).fetchAndSetProducts();
  }

  var _showFavoritesOnly = false;
  @override
  Widget build(BuildContext context) {
    // final productsData = Provider.of<Products>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('MyShop'),
        actions: [
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.favorites) {
                  _showFavoritesOnly = true;
                } else {
                  _showFavoritesOnly = false;
                }
              });
            },
            itemBuilder: (_) => [
              const PopupMenuItem(
                child: Text('Only Favorites'),
                value: FilterOptions.favorites,
              ),
              const PopupMenuItem(
                child: Text('Show All'),
                value: FilterOptions.all,
              ),
            ],
            icon: const Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
          ),
          Consumer<Cart>(
            builder: (_, cartData, ch) => Badge(
              child: IconButton(
                icon: const Icon(
                  Icons.shopping_cart,
                  color: Colors.black,
                ),
                onPressed: () =>
                    Navigator.of(context).pushNamed(CartScreen.routeName),
              ),
              value: cartData.getItemCount.toString(),
            ),
          ),
        ],
        elevation: 4,
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: _productsFuture,
        builder: (_, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (dataSnapshot.hasError) {
            return const Center(child: Text('Error'));
          } else {
            return Consumer<Products>(
              builder: (_, products, ch) {
                return ProductsGrid(_showFavoritesOnly);
              },
            );
          }
        },
      ),
    );
  }
}
