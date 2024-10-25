import 'package:flutter/material.dart';
import 'package:index/UserAdminPage.dart';
import 'login_page.dart';
import 'registro_page.dart';
import 'producto_page.dart';
import 'EcoAmigoPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'TechRecycler',
        theme: ThemeData(
          primarySwatch: Colors.green,
          fontFamily: 'Nerko One',
        ),
        home: LoginPage(),
        routes: {
          '/registro': (context) => RegistroPage(),
          '/producto': (context) => ProductoPage(),
          '/UserAdminPage': (context) => UserAdminPage(),
          '/EcoAmigoPage': (context) => EcoAmigoPage(),
        });
  }
}
