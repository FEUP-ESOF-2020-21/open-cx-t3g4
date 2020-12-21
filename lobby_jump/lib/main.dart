import 'package:flutter/material.dart';
import 'views and controllers/initial_page.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lobby Jump',
      home: new InitialPage(),
    );
  }
}
