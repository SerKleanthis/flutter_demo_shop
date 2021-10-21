import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_config/flutter_config.dart';
import 'packages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var test = FlutterConfig.get('API_KEY');
    print(test);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Auth()),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (ctx) => Products('', '', []),
          update: (ctx, auth, prevProducts) => Products(
            auth.getToken,
            auth.getUserId,
            prevProducts == null ? [] : prevProducts.getItems,
          ),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (ctx) => Orders('', []),
          update: (ctx, auth, prevOrders) => Orders(
            auth.getToken,
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
