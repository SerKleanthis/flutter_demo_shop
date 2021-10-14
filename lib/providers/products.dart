import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import '../packages.dart';

class Products with ChangeNotifier {
  List<Product> _items = dummyData;
  var _showFavoritesOnly = false;

  List<Product> get getItems {
    return [..._items];
  }

  List<Product> get getFavorites {
    return _items.where((item) => item.isFavorites).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  void addProduct(Product newProduct) {
    _items.add(newProduct);
    notifyListeners();
  }

  void showFavoritesOnly() {
    _showFavoritesOnly = true;
    notifyListeners();
  }

  void showAll() {
    _showFavoritesOnly = false;
    notifyListeners();
  }
}
