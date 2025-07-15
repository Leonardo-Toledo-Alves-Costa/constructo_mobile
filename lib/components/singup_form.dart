import 'package:constructo_project/components/user_image_picker.dart';
import 'package:constructo_project/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CadastroForm extends StatefulWidget {
  final Function(String, String, String, String) onNext;

  const CadastroForm({super.key, required this.onNext});

  @override
  State<CadastroForm> createState() => _CadastroFormState();
}

class _CadastroFormState extends State<CadastroForm> {
  final _nomeController = TextEditingController();
  final _sobrenomeController = TextEditingController();
  final _emailController = TextEditingController();
  String _imageUrl = '1';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UserImagePicker(
          onImagePick: (image) {
            setState(() {
              _imageUrl = image.path;
            });
          },
        ),

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
              _imageUrl.isNotEmpty ? _imageUrl : '1',
            );
          },
          child: const Text('Próximo'),
        ),
        TextButton(
          onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
          child: const Text('Já Possuo Conta', style: TextStyle(color: AppColors.letterColorBlackBlue)),
        ),
      ],
    );
  }
}
