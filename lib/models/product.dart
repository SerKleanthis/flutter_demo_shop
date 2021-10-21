import 'package:flutter/material.dart';
import 'package:flutter_demo_shop/data/http_exception.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  static const String url =
      'https://flutter-project-demo-91a09-default-rtdb.firebaseio.com/userFavorites';
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  Future<void> toggleFavoriteStatus(String? token, String userId) async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();

    final uri = Uri.parse(url + '/$userId/$id.json?auth=$token');

    try {
      final response =
          await http.put(uri, body: json.encode({'isFavorite': isFavorite}));

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
