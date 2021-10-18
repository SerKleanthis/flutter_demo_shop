import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../packages.dart';

class Products with ChangeNotifier {
  static const String url =
      'https://flutter-project-demo-91a09-default-rtdb.firebaseio.com/products.json';
  var uri = Uri.parse(url);
  List<Product> items = [];
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

  Future<void> fetchAndSetProducts() async {
    try {
      final response = await http.get(uri);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];
      extractedData.forEach((key, value) {
        loadedProducts.add(Product(
          id: key,
          title: value['title'],
          description: value['description'],
          price: value['price'],
          isFavorites: value['isFavorites'],
          imageUrl: value['imageUrl'],
        ));
      });

      items = loadedProducts;
      notifyListeners();
    } catch (onError) {
      rethrow;
    }
  }

  Future<void> addProduct(Product product) async {
    try {
      final response = await http.post(uri,
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'price': product.price,
            'isFavorites': product.isFavorites,
            // 'id': json.decode(resp)
          }));

      final newProduct = Product(
        title: product.title,
        description: product.description,
        imageUrl: product.imageUrl,
        price: product.price,
        isFavorites: product.isFavorites,
        id: json.decode(response.body)['name'],
      );

      items.add(newProduct);
      notifyListeners();
    } catch (onError) {
      rethrow;
    }
  }

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
