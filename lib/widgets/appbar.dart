import 'package:flutter/material.dart';

class ThemeAppBar extends StatelessWidget {
  String title;

  ThemeAppBar(this.title);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(title),
      elevation: 4,
    );
  }
}
