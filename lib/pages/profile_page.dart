import 'package:constructo_project/components/drawer.dart';
import 'package:constructo_project/services/authentication/authentication_firebase_service.dart';
import 'package:constructo_project/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:constructo_project/utils/app_colors.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Icon(Icons.person_pin, size: 200),
            Text(
              'Usuário',
              style: TextStyle(
                color: AppColors.letterColorLightBlue,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        toolbarHeight: 250,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              'Nome Completo: ',
              style: TextStyle(
                color: AppColors.letterColorBlackBlue,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text('Usuário 1',
              style: TextStyle(
                color: AppColors.letterColorBlackBlue,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 20),
            Text('Email:',
              style: TextStyle(
                color: AppColors.letterColorBlackBlue,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text('usuario1@gmail.com',
              style: TextStyle(
                color: AppColors.letterColorBlackBlue,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 20),
            Text('Codigo de identificação:',
              style: TextStyle(
                color: AppColors.letterColorBlackBlue,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text('11.123.569',
              style: TextStyle(
                color: AppColors.letterColorBlackBlue,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 20),
            Text('Tipo de permissão:',
              style: TextStyle(
                color: AppColors.letterColorBlackBlue,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text('Leitor',
              style: TextStyle(
                color: AppColors.letterColorBlackBlue,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 100),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.letterColorBlackBlue,
                  foregroundColor: AppColors.letterColorLightBlue,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Text('Alterar Senha'),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                await FirebaseAuthService().logout();
                  if (context.mounted) {
                  Navigator.pushReplacementNamed(context, AppRoutes.welcomepage); 
              }  
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: AppColors.alertColor,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Text('Sair dessa conta'),
              ),
            )

          ],
        ),
      ),
      drawer: DrawerComponent(),
    );
  }
}
