import 'package:constructo_project/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:constructo_project/utils/app_colors.dart';

class DrawerComponent extends StatelessWidget {
  const DrawerComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
              color: AppColors.backgroundColor,
            ),
            child: Row(
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: IconButton(
                      icon: Icon(Icons.close, size: 30, color: AppColors.letterColorBlackBlue),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Image.asset(
                      'assets/images/Logo2.png',
                      fit: BoxFit.contain,
                      height: 30,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home_outlined, color: AppColors.letterColorBlackBlue),
            title: Text('Início', style: TextStyle(color: AppColors.letterColorBlackBlue)),
            onTap: () {
              Navigator.pushNamed(context, '/homepage');
            },
          ),
          ListTile(
            leading: Icon(Icons.inventory_2_outlined, color: AppColors.letterColorBlackBlue),
            title: Text('Produtos', style: TextStyle(color: AppColors.letterColorBlackBlue)),
            onTap: () {
              Navigator.pushNamed(context, '/produtos');
            },
          ),
          ListTile(
            leading: Icon(Icons.warehouse_outlined, color: AppColors.letterColorBlackBlue),
            title: Text('Estoque', style: TextStyle(color: AppColors.letterColorBlackBlue)),
            onTap: () {
              Navigator.pushNamed(context, '/estoque');
            },
          ),
          ListTile(
            leading: Icon(Icons.grading_outlined, color: AppColors.letterColorBlackBlue),
            title: Text('Registro de baixas', style: TextStyle(color: AppColors.letterColorBlackBlue)),
            onTap: () {
              Navigator.pushNamed(context, '/registro_baixas');
            },
          ),
          ListTile(
            leading: Icon(Icons.person_rounded, color: AppColors.letterColorBlackBlue),
            title: Text('Perfil', style: TextStyle(color: AppColors.letterColorBlackBlue)),
            onTap: () {
              Navigator.pushNamed(context, '/perfil');
            },
          ),
        ],
      ),
    );
  }
}