import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_demo_shop/screens/cart_screen.dart';
import 'package:provider/provider.dart';
import '../packages.dart';

enum FilterOptions { Favorites, All }

class MainScreen extends StatefulWidget {
  static const String routeName = '/';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var _showFavoritesOnly = false;
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('MyShop'),
        actions: [
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorites) {
                  _showFavoritesOnly = true;
                } else {
                  _showFavoritesOnly = false;
                }
              });
            },
            itemBuilder: (_) => [
              const PopupMenuItem(
                child: Text('Only Favorites'),
                value: FilterOptions.Favorites,
              ),
              const PopupMenuItem(
                child: Text('Show All'),
                value: FilterOptions.All,
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
      body: ProductsGrid(_showFavoritesOnly),
    );
  }
}
