import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back),
        ),
        title: Text('Autenticação'),
      ),
      body: Center(
        child: Text(
          'Tela de autenticação',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
    );
  }
}
