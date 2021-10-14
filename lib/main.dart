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
        ChangeNotifierProvider(create: (ctx) => Products()),
        ChangeNotifierProvider(create: (ctx) => Cart()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: myThemeData(context),
        initialRoute: MainScreen.routeName,
        onGenerateRoute: GenerateRoute.generateRoute,
      ),
    );
  }
}
