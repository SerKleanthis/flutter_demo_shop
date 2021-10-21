import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';
import 'dart:convert';
import '../packages.dart';

class Products with ChangeNotifier {
  static const String productsUrl =
      'https://flutter-project-demo-91a09-default-rtdb.firebaseio.com/products';
  static const String favoritesUrl =
      'https://flutter-project-demo-91a09-default-rtdb.firebaseio.com/userFavorites';
  final String? authToken;
  final String? userId;
  List<Product> _items = [];

  Products(this.authToken, this.userId, this._items);

  // Getters
  List<Product> get getItems {
    return [..._items];
  }

  List<Product> get getFavorites {
    return _items.where((item) => item.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  Future<void> fetchAndSetProducts([bool filterByUser = false]) async {
    var filterString =
        filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
    var productsUri =
        Uri.parse(productsUrl + '.json?auth=$authToken&$filterString');
    var favoritesUri = Uri.parse(productsUrl + '/$userId.json?auth=$authToken');

    try {
      final response = await http.get(productsUri);
      final productsData = json.decode(response.body) as Map<String, dynamic>;
      final favResponse = await http.get(favoritesUri);
      final favoritesData = json.decode(favResponse.body);

      final List<Product> loadedData = [];
      productsData.forEach((key, value) {
        loadedData.add(Product(
          id: key,
          title: value['title'],
          description: value['description'],
          price: value['price'],
          isFavorite:
              favoritesData == null ? false : favoritesData[value] ?? false,
          imageUrl: value['imageUrl'],
        ));
      });

      _items = loadedData;
      notifyListeners();
    } on HttpException catch (onError) {
      throw HttpException(onError);
    } catch (onError) {
      throw Exception(onError);
    }
  }

  Future<void> addProduct(Product product) async {
    var uri = Uri.parse(productsUrl + '.json?auth=$authToken');
    try {
      final response = await http.post(uri,
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'price': product.price,
            'creatorId': userId,
          }));

      final newProduct = Product(
        title: product.title,
        description: product.description,
        imageUrl: product.imageUrl,
        price: product.price,
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
        var uri = Uri.parse(productsUrl + '/$id.json?auth=$authToken');
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
    var uri = Uri.parse(productsUrl + '/$id.json?auth=$authToken');

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
