import 'package:constructo_project/utils/app_colors.dart';
import 'package:constructo_project/utils/app_routes.dart';
import 'package:flutter/material.dart';
import '../components/singup_form.dart';
import '../services/authentication/authentication_firebase_service.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String? nome;
  String? sobrenome;
  String? email;
  String imageURL = '1';

  final _senhaController = TextEditingController();
  final _confirmarSenhaController = TextEditingController();

  bool _mostrarSenha = false;

void _realizarCadastro() async {
  if (_senhaController.text != _confirmarSenhaController.text) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: 
        Text('As senhas não coincidem',
        textAlign: TextAlign.center, 
        style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.alertColor,
        duration: Duration(seconds: 1),
      ),
    );
    return;
  }

  final employeeCode = await FirebaseAuthService().registrarUsuarioComFirestore(
  nome: nome!,
  sobrenome: sobrenome!,
  email: email!,
  senha: _senhaController.text,
  imageURL: imageURL,
);

  if (!mounted) return;

  if (employeeCode != null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 5),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Parabéns $nome! Sua conta foi criada com sucesso!',
                style: const TextStyle(color: Colors.white)),
            const SizedBox(height: 10),
            Text('Seu código de identificação é:\n$employeeCode',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
    Future.delayed(const Duration(seconds: 5), () {
      if (!mounted) return;
      Navigator.pushNamed(context, AppRoutes.homepage);
    });
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content:
       Text('Erro ao criar conta')),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Constructo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: nome == null
            ? CadastroForm(
                onNext: (n, s, e, i) => setState(() {
                  nome = n;
                  sobrenome = s;
                  email = e;
                  imageURL = i;
                }),
              )
            : Column(
                children: [
                  const Text('Crie uma senha', style: TextStyle(fontSize: 20)),
                  TextField(
                    controller: _senhaController,
                    obscureText: !_mostrarSenha,
                    decoration: InputDecoration(
                      labelText: 'Senha',
                      suffixIcon: IconButton(
                        icon: Icon(_mostrarSenha ? Icons.visibility : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _mostrarSenha = !_mostrarSenha;
                          });
                        },
                      ),
                    ),
                  ),
                  TextField(
                    controller: _confirmarSenhaController,
                    obscureText: !_mostrarSenha,
                    decoration: const InputDecoration(labelText: 'Confirmar Senha'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _realizarCadastro,
                    child: const Text('Realizar Cadastro'),
                  ),
                  TextButton(
                    onPressed: () => setState(() => nome = null),
                    child: const Text('Voltar ao formulário'),
                  ),
                ],
              ),
      ),
    );
  }
}
