import 'package:constructo_project/components/drawer.dart';
import 'package:constructo_project/components/stock_list.dart';
import 'package:constructo_project/components/stock_list_tile.dart';
import 'package:constructo_project/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:constructo_project/components/stock.dart';
import 'package:provider/provider.dart';

class StockPage extends StatelessWidget {
  const StockPage({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/Logo.png', height: 40),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.person_pin),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(35.0),
            child: SizedBox(
              child: Row(
                children: [
                  Text(
                    'Estoque',
                    style: TextStyle(
                      color: Color(0xFF061D3D),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 125),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/cadastro_estoque');
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: AppColors.brandColor1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.add, size: 15),
                        Text('Cadastrar'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: StockListTile(),
          ),
        ],
      ),
      drawer: DrawerComponent(),
    );
  }
}