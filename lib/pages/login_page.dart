import 'package:constructo_project/utils/app_colors.dart';
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
    final sucesso = await FirebaseAuthService().loginUsuario(
      _emailController.text,
      _senhaController.text,
    );

    if (!mounted) return;

    if (sucesso) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login realizado com sucesso!')),
      );
      Navigator.pushNamed(context, AppRoutes.homepage);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Erro ao fazer login')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Image.asset('assets/images/Logo2.png'),
        backgroundColor: AppColors.backgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Entrar',
              style: Theme.of(context).textTheme.headlineLarge,
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 15.0),
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
                  icon: Icon(
                    _mostrarSenha ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () =>
                      setState(() => _mostrarSenha = !_mostrarSenha),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.mudarsenha);
              },
              child: const Text('Esqueci minha senha', style: TextStyle(color: AppColors.letterColorBlackBlue)),
            ),
            ElevatedButton(
              onPressed: _fazerLogin,
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(AppColors.brandColor0),
                foregroundColor: WidgetStateProperty.all(Colors.white)
              ),
              child: const Text('Entrar'),
            ),
            TextButton(
              onPressed: () =>
                  Navigator.pushNamed(context, AppRoutes.signuppage),
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.white),
                    foregroundColor: WidgetStateProperty.all(AppColors.secondaryColor0)
                  ),
              child: const Text('Criar Conta'),
            ),
          ],
        ),
      ),
    );
  }
}
