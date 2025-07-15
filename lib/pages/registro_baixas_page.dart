import 'package:constructo_project/components/baixas_list_tile.dart';
import 'package:constructo_project/components/drawer.dart';
import 'package:constructo_project/utils/app_colors.dart';
import 'package:flutter/material.dart';

class RegistroBaixasPage extends StatelessWidget {
  const RegistroBaixasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/Logo.png', height: 40),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
            icon: Icon(Icons.person_pin, size: 35),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Registro de Baixas',
              style: TextStyle(
                color: AppColors.letterColorBlackBlue,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/cadastro_baixa');
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: AppColors.brandColor0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text('Registrar Baixa'),
                  ),
            SizedBox(height: 20),
            Expanded(child: BaixasListTile())
          ],
        ),
      ),
      drawer: DrawerComponent(),
    );
  }
}