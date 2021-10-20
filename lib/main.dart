import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'packages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Auth()),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (ctx) => Products('', []),
          update: (ctx, auth, prevProducts) => Products(
            auth.getToken,
            prevProducts == null ? [] : prevProducts.getItems,
          ),
        ),
        ChangeNotifierProvider(create: (ctx) => Cart()),
        ChangeNotifierProvider(create: (ctx) => Orders()),
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
