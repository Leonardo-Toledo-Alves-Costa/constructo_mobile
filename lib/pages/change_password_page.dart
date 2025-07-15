import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _senhaController = TextEditingController();
  final _confirmarSenhaController = TextEditingController();
  final _emailController = TextEditingController();

  bool _mostrarSenha = false;

  Future<void> _sendPasswordResetEmail() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('E-mail de redefinição de senha enviado!')),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao enviar e-mail: $e')),
      );
    }
  }

  void _alterarSenha() async{
    if (_senhaController.text != _confirmarSenhaController.text) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('As senhas não coincidem',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 1),
        ),
      );
      return;
    }
    Future<bool> updatePassword(String newPassword) async {
      try {
        User? user = FirebaseAuth.instance.currentUser;
        await user?.updatePassword(newPassword);
        return true;
      } catch (e) {
        return false;
      }
    }
    final success = await updatePassword(_senhaController.text);
    if (!mounted) return;
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Senha alterada com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
      ),
      body: Center(
        child: Column(
          children: [
            if (user == null)
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'E-mail'),
              ),
            if (user != null) 
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
            if (user != null)
            TextField(
                    controller: _confirmarSenhaController,
                    obscureText: !_mostrarSenha,
                    decoration: const InputDecoration(labelText: 'Confirmar Senha'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (user == null) {
                        _sendPasswordResetEmail();
                      } else {
                        _alterarSenha();
                      }
                    },
                    child: const Text('Alterar Senha'),
                  ),
                ],
              ),
            ),
          );
        }
      }