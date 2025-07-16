import 'package:constructo_project/components/drawer.dart';
import 'package:flutter/material.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/Logo.png', height: 40),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/perfil');
            },
            icon: Icon(Icons.person_pin, size: 35),
          ),
        ],
      ),
      body: Center(
        child: Text(
          'Products page',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
      drawer: DrawerComponent(),
    );
  }
}
