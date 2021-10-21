import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../packages.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  static const url =
      'https://flutter-project-demo-91a09-default-rtdb.firebaseio.com/orders';
  final String? authToken;
  final String? userId;
  List<OrderItem> _orders = [];

  Orders(this.authToken, this.userId, this._orders);

  List<OrderItem> get getOrders {
    return _orders;
  }

  Future<void> fetchOrders() async {
    final uri = Uri.parse(url + '/$userId.json?auth=$authToken');

    try {
      final response = await http.get(uri);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<OrderItem> loadedOrders = [];
      extractedData.forEach((key, value) {
        loadedOrders.add(OrderItem(
          id: key,
          amount: value['amount'],
          dateTime: DateTime.parse(value['dateTime']),
          products: (value['products'] as List<dynamic>)
              .map(
                (item) => CartItem(
                  // id: item['id'],
                  price: item['price'],
                  quantity: item['quantity'],
                  title: item['title'],
                  productId: item['productId'],
                ),
              )
              .toList(),
        ));
      });

      _orders = loadedOrders;
      notifyListeners();
    } on HttpException catch (onError) {
      throw HttpException(onError);
    } catch (onError) {
      throw Exception(onError);
    }
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final uri = Uri.parse(url + '/$userId.json?auth=$authToken');

    final timestamp = DateTime.now();

    try {
      final response = await http.post(uri,
          body: json.encode({
            'amount': total,
            'dateTime': timestamp.toIso8601String(),
            'products': cartProducts
                .map((item) => {
                      // 'id': item.id,
                      'productId': item.productId,
                      'title': item.title,
                      'quantity': item.quantity,
                      'price': item.price,
                    })
                .toList(),
          }));

      _orders.insert(
          0,
          OrderItem(
            id: json.decode(response.body)['name'],
            amount: total,
            products: cartProducts,
            dateTime: timestamp,
          ));
      notifyListeners();
    } on HttpException catch (onError) {
      throw HttpException(onError);
    } catch (onError) {
      throw Exception(onError);
    }
  }
}
