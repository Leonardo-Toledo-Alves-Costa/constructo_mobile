import 'dart:io';
import 'package:flutter/material.dart';
import 'package:constructo_project/components/user_image_picker.dart';
import 'package:validatorless/validatorless.dart';
import '../models/auth_form_data.dart';

class AuthForm extends StatefulWidget {
  final void Function(AuthFormData) onSubmit;

  const AuthForm({super.key, required this.onSubmit,});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _formData = AuthFormData();

  void _handleImagePick(File image){
    _formData.image = image;
  }

  void _showError(String errorMsg){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorMsg),
        backgroundColor: Theme.of(context).colorScheme.error,
      )
    );
  }

  void _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    if(_formData.image == null && _formData.isSingup){
      return _showError('Imagem não selecionada');
    }

    widget.onSubmit(_formData);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(20.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              if (_formData.isSingup) UserImagePicker(onImagePick: _handleImagePick),
              if (_formData.isSingup)
                TextFormField(
                  key: ValueKey('name'),
                  initialValue: _formData.name,
                  onChanged: (name) => _formData.name = name,
                  decoration: InputDecoration(labelText: 'Nome de Usuário'),
                  validator: Validatorless.multiple([
                  Validatorless.min(
                  4,
                  'O nome de usuário deve conter pelo menos 4 caracteres',
                ),
                Validatorless.required('O nome de usuário deve conter pelo menos 4 caracteres')
                ]) 
                ),
              TextFormField(
                key: ValueKey('email'),
                initialValue: _formData.email,
                onChanged: (email) => _formData.email = email,
                decoration: InputDecoration(labelText: 'Email'),
                validator: Validatorless.multiple([
                 Validatorless.email('Email inválido'),
                 Validatorless.required('Email inválido'),
              ]),
             ),
              TextFormField(
                obscureText: true,
                key: ValueKey('password'),
                initialValue: _formData.password,
                onChanged: (password) => _formData.password = password,
                decoration: InputDecoration(labelText: 'Senha'),
                validator: Validatorless.multiple([
                  Validatorless.min(
                  6,
                  'A senha deve conter pelo menos 6 caracteres',
                ),
                Validatorless.required('A senha deve conter pelo menos 6 caracteres')
                ]) 
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _submit,
                child: Text(_formData.isLogin ? 'Entrar' : 'Cadastrar'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _formData.toggleAuthMode();
                  });
                },
                child: Text(
                  _formData.isLogin
                      ? 'Criar nova conta'
                      : 'Já possui uma conta?',
                  style: TextStyle(color: Colors.blueGrey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}