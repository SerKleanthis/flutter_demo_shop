import 'package:flutter/material.dart';
import '../packages.dart';

class GenerateRoute {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => AuthScreen());
      case '/main':
        return MaterialPageRoute(builder: (_) => MainScreen());
      case '/details':
        final args = settings.arguments as String;
        if (args is String) {
          return MaterialPageRoute(builder: (_) => DetailsScreen(args));
        }
        return _errorRoute();
      case '/cart':
        return MaterialPageRoute(builder: (_) => CartScreen());
      case '/orders':
        return MaterialPageRoute(builder: (_) => OrdersScreen());
      case '/user_products':
        return MaterialPageRoute(builder: (_) => UserProductsScreen());
      case '/edit':
        if (settings.arguments is Product) {
          final args = settings.arguments as Product;
          return MaterialPageRoute(builder: (_) => EditProductScreen(args));
        }
        return MaterialPageRoute(builder: (_) => EditProductScreen(null));
      // case '/auth':
    }

    return _errorRoute();
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
