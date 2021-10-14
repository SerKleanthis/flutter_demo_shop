import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import '../packages.dart';

class Products with ChangeNotifier {
  List<Product> items = dummyData;

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
}
