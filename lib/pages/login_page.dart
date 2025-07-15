import 'package:constructo_project/utils/app_routes.dart';
import 'package:flutter/material.dart';
import '../services/authentication/authentication_firebase_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  bool _mostrarSenha = false;

 void _fazerLogin() async {
  final sucesso = await FirebaseAuthService()
      .loginUsuario(_emailController.text, _senhaController.text);

  if (!mounted) return; 

  if (sucesso) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Login realizado com sucesso!')),
    );
    Navigator.pushNamed(context, AppRoutes.homepage);
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Erro ao fazer login')),
    );
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'E-mail'),
            ),
            TextField(
              controller: _senhaController,
              obscureText: !_mostrarSenha,
              decoration: InputDecoration(
                labelText: 'Senha',
                suffixIcon: IconButton(
                  icon: Icon(_mostrarSenha ? Icons.visibility : Icons.visibility_off),
                  onPressed: () => setState(() => _mostrarSenha = !_mostrarSenha),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _fazerLogin,
              child: const Text('Entrar'),
            ),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, AppRoutes.signuppage),
              child: const Text('Criar Conta'),
            ),
          ],
        ),
      ),
    );
  }
}
