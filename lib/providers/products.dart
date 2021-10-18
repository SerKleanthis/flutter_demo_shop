import 'package:flutter/material.dart';
import '../packages.dart';

class Products with ChangeNotifier {
<<<<<<< HEAD
  List<Product> items = dummyData;
=======
  final List<Product> _items = dummyData;
  // var _showFavoritesOnly = false;
>>>>>>> User-Interface-branch

  List<Product> get getItems {
    return [...items];
  }

  List<Product> get getFavorites {
    return items.where((item) => item.isFavorites).toList();
  }

  Product findById(String id) {
    return items.firstWhere((prod) => prod.id == id);
  }

  void addProduct(Product newProduct) {
<<<<<<< HEAD
    items.add(newProduct);
=======
    _items.add(newProduct);
    notifyListeners();
  }

  // void showFavoritesOnly() {
  //   _showFavoritesOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }

  void updateProduct(String id, Product updatedProduct) {
    final productIndex = _items.indexWhere((prod) => prod.id == id);
    _items[productIndex] = updatedProduct;
    notifyListeners();
  }

  void deleteProduct(String id) {
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void restoreProduct(String id) {
    Product restoredProduct = _items.firstWhere((element) => element.id == id);
    addProduct(restoredProduct);
>>>>>>> User-Interface-branch
    notifyListeners();
  }
}
