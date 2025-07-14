import 'package:flutter/material.dart';

class CadastroForm extends StatefulWidget {
  final Function(String, String, String) onNext;

  const CadastroForm({super.key, required this.onNext});

  @override
  State<CadastroForm> createState() => _CadastroFormState();
}

class _CadastroFormState extends State<CadastroForm> {
  final _nomeController = TextEditingController();
  final _sobrenomeController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CircleAvatar(radius: 40, child: Icon(Icons.person, size: 40)),
        const SizedBox(height: 8),
        const Text('Adicionar Imagem', style: TextStyle(decoration: TextDecoration.underline)),

        const SizedBox(height: 20),
        TextField(
          controller: _nomeController,
          decoration: const InputDecoration(labelText: 'Nome'),
        ),
        TextField(
          controller: _sobrenomeController,
          decoration: const InputDecoration(labelText: 'Sobrenome'),
        ),
        TextField(
          controller: _emailController,
          decoration: const InputDecoration(labelText: 'E-mail'),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            widget.onNext(
              _nomeController.text,
              _sobrenomeController.text,
              _emailController.text,
            );
          },
          child: const Text('Próximo'),
        ),
        TextButton(
          onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
          child: const Text('Já Possuo Conta'),
        ),
      ],
    );
  }
}
