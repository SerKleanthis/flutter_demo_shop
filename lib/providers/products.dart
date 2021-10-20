import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../packages.dart';

class Products with ChangeNotifier {
  static const String url =
      'https://flutter-project-demo-91a09-default-rtdb.firebaseio.com';
  final String? authToken;
  List<Product> _items = [];

  Products(this.authToken, this._items);

  // Getters
  List<Product> get getItems {
    return [..._items];
  }

  List<Product> get getFavorites {
    return _items.where((item) => item.isFavorites).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  Future<void> fetchAndSetProducts() async {
    var uri = Uri.parse(url + '/products.json?auth=$authToken');
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

      _items = loadedProducts;
      notifyListeners();
    } on HttpException catch (onError) {
      throw HttpException(onError);
    } catch (onError) {
      throw Exception(onError);
    }
  }

  Future<void> addProduct(Product product) async {
    var uri = Uri.parse(url + '/products.json');
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

      _items.add(newProduct);
      notifyListeners();
    } on HttpException catch (onError) {
      throw HttpException(onError);
    } catch (onError) {
      throw Exception(onError);
    }
  }

  Future<void> updateProduct(String id, Product updatedProduct) async {
    final productIndex = _items.indexWhere((prod) => prod.id == id);

    try {
      if (productIndex >= 0) {
        var uri = Uri.parse(url + '/products/$id.json');
        final response = await http.patch(uri,
            body: json.encode({
              'title': updatedProduct.title,
              'description': updatedProduct.description,
              'imageUrl': updatedProduct.imageUrl,
              'price': updatedProduct.price,
              // 'isFavorites': updatedProduct.isFavorites,
            }));
        log(response.body.toString());

        _items[productIndex] = updatedProduct;
        notifyListeners();
      } else {}
    } on HttpException catch (onError) {
      throw HttpException(onError);
    } catch (onError) {
      throw Exception(onError);
    }
  }

  Future<void> deleteProduct(String id) async {
    var uri = Uri.parse(url + '/products/$id.json');

    try {
      final response = await http.delete(uri);
      log(response.body.toString());

      _items.removeWhere((element) => element.id == id);
      notifyListeners();
    } on HttpException catch (onError) {
      throw HttpException(onError);
    } catch (onError) {
      throw Exception(onError);
    }
  }

  void restoreProduct(String id) {
    Product restoredProduct = _items.firstWhere((element) => element.id == id);
    addProduct(restoredProduct);
    notifyListeners();
  }
}
