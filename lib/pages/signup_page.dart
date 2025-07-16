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
          content: Text(
            'As senhas não coincidem',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: AppColors.alertColor,
          duration: Duration(seconds: 1),
        ),
      );
      return;
    }

    final employeeCode = await FirebaseAuthService()
        .registrarUsuarioComFirestore(
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
          elevation: 10,
          backgroundColor: AppColors.backgroundColor,
          duration: const Duration(seconds: 5),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Parabéns $nome, sua conta foi criada com sucesso!',
                style: const TextStyle(color: AppColors.letterColorBlackBlue),
              ),
              SizedBox(height: 5),
              Icon(Icons.check_circle, color: AppColors.confirmationColor),
              const SizedBox(height: 10),
              Text(
                'Seu código de identificação é:\n$employeeCode',
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.letterColorBlackBlue),
              ),
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
        const SnackBar(
          content: Text(
            'Por favor, preencha todas as informações antes de continuar',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: AppColors.alertColor,
          duration: Duration(seconds: 2),
        ),
      );
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        'Cadastrar',
                        style: TextStyle(
                          color: AppColors.secondaryColor0,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Senha',
                      style: TextStyle(
                        color: AppColors.secondaryColor0,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  TextField(
                    controller: _senhaController,
                    obscureText: !_mostrarSenha,
                    decoration: InputDecoration(
                      labelText: 'Senha',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _mostrarSenha
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _mostrarSenha = !_mostrarSenha;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Confirmar Senha',
                      style: TextStyle(
                        color: AppColors.secondaryColor0,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  TextField(
                    controller: _confirmarSenhaController,
                    obscureText: !_mostrarSenha,
                    decoration: InputDecoration(
                      labelText: 'Confirmar Senha',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _realizarCadastro,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.brandColor0,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Realizar Cadastro',
                        style: TextStyle(color: AppColors.letterColorLightBlue),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () => setState(() => nome = null),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: const BorderSide(
                          color: AppColors.secondaryColor0,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Voltar ao formulário',
                        style: TextStyle(color: AppColors.letterColorBlackBlue),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
