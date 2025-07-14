import 'package:flutter/material.dart';
import '../components/singup_form.dart';
import '../services/authentication/authentication_firebase_service.dart';

class SingupPage extends StatefulWidget {
  const SingupPage({super.key});

  @override
  State<SingupPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<SingupPage> {
  String? nome;
  String? sobrenome;
  String? email;

  final _senhaController = TextEditingController();
  final _confirmarSenhaController = TextEditingController();

  bool _mostrarSenha = false;

void _realizarCadastro() async {
  if (_senhaController.text != _confirmarSenhaController.text) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('As senhas não coincidem')),
    );
    return;
  }

  final id = await FirebaseAuthService().registrarUsuario(email!, _senhaController.text);

  if (!mounted) return;

  if (id != null) {
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
            Text('Seu código de identificação é:\n$id',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
    Future.delayed(const Duration(seconds: 5), () {
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/login');
    });
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Erro ao criar conta')),
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
                onNext: (n, s, e) => setState(() {
                  nome = n;
                  sobrenome = s;
                  email = e;
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
