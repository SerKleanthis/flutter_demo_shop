import 'package:flutter/material.dart';
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
  List<OrderItem> orders = [];

  List<OrderItem> get getOrders {
    return orders;
  }

  void addOrder(List<CartItem> cartProducts, double total) {
    orders.insert(
        0,
        OrderItem(
          id: DateTime.now().toString(),
          amount: total,
          products: cartProducts,
          dateTime: DateTime.now(),
        ));
    notifyListeners();
  }
}
