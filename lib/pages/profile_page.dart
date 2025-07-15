import 'dart:io';

import 'package:constructo_project/components/drawer.dart';
import 'package:constructo_project/components/user_firebase.dart';
import 'package:constructo_project/services/authentication/authentication_firebase_service.dart';
import 'package:constructo_project/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:constructo_project/utils/app_colors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _userFirebase = UserFirebase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            StreamBuilder(
              stream: _userFirebase.userStream,
              builder: (context, snapshot) {
                final user = snapshot.data;
                return Image.file(
                  File(user?.imageURL ?? ''),
                );
              },
            ),
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
        child: StreamBuilder(stream: _userFirebase.userStream, builder: (context, snapshot) {
              final user = snapshot.data;
              return Column(
                children: [
            SizedBox(
              height: 20,
            ),
            Text(
              'Nome:',
              style: TextStyle(
                color: AppColors.letterColorBlackBlue,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              user?.name ?? '',
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
            Text(user?.email ?? '',
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
            Text(user?.id ?? '',
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
            Text(user?.role ?? '',
              style: TextStyle(
                color: AppColors.letterColorBlackBlue,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 100),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.mudarsenha);
                },
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
                  Navigator.pushReplacementNamed(context, AppRoutes.loginpage); 
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
              ),
            ],
            );
          }),
      ),
      drawer: DrawerComponent(),
    );
  }
}
