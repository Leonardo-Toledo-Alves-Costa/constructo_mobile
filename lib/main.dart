import 'package:constructo_project/pages/welcome_page.dart';
import 'package:constructo_project/utils/app_routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Constructo App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.deepOrange,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white
        ),
      ),
      routes: {
        AppRoutes.welcomepage: (context) => const WelcomePage(),
      },
    );
  }
}
  
