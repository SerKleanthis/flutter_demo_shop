import 'package:flutter/material.dart';
import 'package:flutter_demo_shop/data/http_exception.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  static const String url =
      'https://flutter-project-demo-91a09-default-rtdb.firebaseio.com/products';
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorites;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorites = false,
  });

  Future<void> toggleFavoriteStatus(String? token) async {
    final oldStatus = isFavorites;
    isFavorites = !isFavorites;
    notifyListeners();

    final uri = Uri.parse(url + '/$id.json?auth=$token');

    try {
      final response = await http.patch(uri,
          body: json.encode({
            'isFavorites': isFavorites,
          }));

      // if (response.statusCode >= 400) {
      //   isFavorites = oldStatus;
      //   notifyListeners();
      // }
    } on HttpException catch (onError) {
      throw HttpException(onError);
    } catch (error) {
      throw Exception(error);
    }
  }
}
