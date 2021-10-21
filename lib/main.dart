import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'packages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();
  await FlutterConfig.loadEnvVariables();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Auth()),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (ctx) => Products(null, null, []),
          update: (ctx, auth, prevProducts) => Products(
            auth.getToken,
            auth.getUserId,
            prevProducts == null ? [] : prevProducts.getItems,
          ),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (ctx) => Orders(null, null, []),
          update: (ctx, auth, prevOrders) => Orders(
            auth.getToken,
            auth.getUserId,
            prevOrders == null ? [] : prevOrders.getOrders,
          ),
        ),
        ChangeNotifierProvider(create: (ctx) => Cart()),
      ],
      child: Consumer<Auth>(
        builder: (_, auth, ch) => MaterialApp(
          title: 'Flutter Demo',
          theme: myThemeData(context),
          initialRoute:
              auth.isAuth ? MainScreen.routeName : AuthScreen.routeName,
          onGenerateRoute: GenerateRoute.generateRoute,
        ),
      ),
    );
  }
}
