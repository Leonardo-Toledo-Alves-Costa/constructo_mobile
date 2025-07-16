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
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Cadastrar',
              style: TextStyle(
                color: AppColors.secondaryColor0,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        UserImagePicker(
          onImagePick: (image) {
            setState(() {
              _imageUrl = image.path;
            });
          },
        ),
        const SizedBox(height: 35),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Nome',
            style: TextStyle(
              color: AppColors.secondaryColor0,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        TextField(
          controller: _nomeController,
          decoration: InputDecoration(
            labelText: 'Nome',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          ),
        ),
        const SizedBox(height: 16),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Sobrenome',
            style: TextStyle(
              color: AppColors.secondaryColor0,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        TextField(
          controller: _sobrenomeController,
          decoration: InputDecoration(
            labelText: 'Sobrenome',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          ),
        ),
        const SizedBox(height: 16),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'E-mail',
            style: TextStyle(
              color: AppColors.secondaryColor0,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        TextField(
          controller: _emailController,
          decoration: InputDecoration(
            labelText: 'E-mail',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          ),
        ),
        const SizedBox(height: 40),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              widget.onNext(
                _nomeController.text.trim(),
                _sobrenomeController.text.trim(),
                _emailController.text.trim(),
                _imageUrl.isNotEmpty ? _imageUrl : '1',
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.brandColor0,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Próximo',
              style: TextStyle(color: AppColors.letterColorLightBlue),
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              side: const BorderSide(color: AppColors.secondaryColor0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Já Possuo Conta',
              style: TextStyle(color: AppColors.letterColorBlackBlue),
            ),
          ),
        ),
      ],
    );
  }
}
