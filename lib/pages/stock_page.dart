import 'package:constructo_project/components/drawer.dart';
import 'package:constructo_project/components/stock_list_tile.dart';
import 'package:constructo_project/utils/app_colors.dart';
import 'package:flutter/material.dart';

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
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
            icon: Icon(Icons.person_pin, size: 35,),
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
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: SizedBox(
              width: 350,
              height: 50,
              child: TextField(
                expands: true,
                maxLines: null,
                minLines: null,
                decoration: InputDecoration(
                  hint: Row(
                    children: [
                      Icon(Icons.search, color: AppColors.letterColorBlackBlue),
                      SizedBox(width: 6),
                      Text('Pesquisar', style: TextStyle(
                      color: AppColors.letterColorBlackBlue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      )),
                    ],
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  contentPadding: EdgeInsets.all(5.0),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 0.0),
            child: Row(
              children: [
                TextButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(AppColors.letterColorBlackBlue),
                    fixedSize: WidgetStateProperty.all(Size(125, 45)),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/filtro_estoque');
                  },
                  child: Row(
                    children: [
                      Icon(Icons.filter_alt, color: AppColors.backgroundColor),
                      SizedBox(width: 8),
                      Text('Filtros',
                          style: TextStyle(
                          color: AppColors.backgroundColor,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.backgroundColor,
                    border: Border.all(color: AppColors.backgroundColor),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      borderRadius: BorderRadius.circular(15.0),
                      hint: Text('Ordenar por'),
                      items: ['Quantidade', 'N° Lote', 'Data de cadastro', 'Tipo'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {},
                    ),
                  ),
                )
              ],
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