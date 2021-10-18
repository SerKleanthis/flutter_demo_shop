import 'package:flutter/material.dart';
import '../packages.dart';

class Products with ChangeNotifier {
  final List<Product> items = dummyData;
  // var _showFavoritesOnly = false;

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
    items.add(newProduct);
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
    final productIndex = items.indexWhere((prod) => prod.id == id);
    items[productIndex] = updatedProduct;
    notifyListeners();
  }

  void deleteProduct(String id) {
    items.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void restoreProduct(String id) {
    Product restoredProduct = items.firstWhere((element) => element.id == id);
    addProduct(restoredProduct);
    notifyListeners();
  }
}
