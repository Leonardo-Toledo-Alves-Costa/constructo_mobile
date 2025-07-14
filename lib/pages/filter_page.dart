import 'package:constructo_project/utils/app_colors.dart';
import 'package:flutter/material.dart';

class FilterPage extends StatelessWidget {
  const FilterPage({super.key});

  @override
  Widget build(BuildContext context) {
        final List<String> tipos = [
      'Tijolo e Blocos',
      'Ferragens e Metais',
      'Ferramentas e Equipamentos',
    ];
    return Scaffold(
      appBar: AppBar(
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Filtros', 
              style: TextStyle(
                color: AppColors.letterColorBlackBlue,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text('Tipo de Produto',
              style: TextStyle(
                color: AppColors.letterColorBlackBlue,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            FormField(builder: (FormFieldState state) {
              return InputDecorator(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0),
                  enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    hint: Text('Escolha o tipo'),
                    items: tipos.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                      );
                      }).toList(),
                    onChanged: (String? newValue) {
                    },
                  ),
                ),
              );
            }),
            SizedBox(height: 20),
            Text('Número do Lote',
              style: TextStyle(
                color: AppColors.letterColorBlackBlue,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                contentPadding: EdgeInsets.all(5),
                hintText: 'Lote',
              ),
              onSubmitted: (value){
              },
            ),
            SizedBox(height: 20),
            Text('Data de Cadastro',
              style: TextStyle(
                color: AppColors.letterColorBlackBlue,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text('De: ', 
                  style: TextStyle(
                    color: AppColors.letterColorBlackBlue,
                    fontSize: 16,
                  ),
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      contentPadding: EdgeInsets.all(5),
                      hintText: 'dd/mm/aaaa',
                    ),
                    onSubmitted: (value){
                    },
                  ),
                ),
                SizedBox(width: 50),
                Text('Até: ', 
                  style: TextStyle(
                    color: AppColors.letterColorBlackBlue,
                    fontSize: 16,
                  ),
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      contentPadding: EdgeInsets.all(5),
                      hintText: 'dd/mm/aaaa',
                    ),
                    onSubmitted: (value){
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}