import 'package:flutter/material.dart';
import 'package:flutter_demo_shop/screens/cart_screen.dart';
import '../packages.dart';

class GenerateRoute {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => MainScreen());
      case '/details':
        final args = settings.arguments as String;
        if (args is String) {
          return MaterialPageRoute(builder: (_) => DetailsScreen(args));
        }
        return _errorRoute();
      case '/cart':
        return MaterialPageRoute(builder: (_) => CartScreen());
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
