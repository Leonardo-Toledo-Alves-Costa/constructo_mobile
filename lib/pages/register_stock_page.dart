import 'package:constructo_project/utils/app_colors.dart';
import 'package:flutter/material.dart';

class RegisterStockPage extends StatelessWidget {
  const RegisterStockPage({super.key});

  @override
  Widget build(BuildContext context) {

    final ListTipos = [
      'Tijolo e Blocos',
      'Ferragens e Metais',
      'Ferramentas e Equipamentos',
    ];
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/Logo2.png', height: 50),
        centerTitle: true,
        backgroundColor: AppColors.letterColorLightBlue,
        toolbarHeight: 200,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              'Cadastrar no Estoque',
              style: TextStyle(
                color: Color(0xFF061D3D),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nome do Produto: ',
                  style: TextStyle(
                    color: AppColors.letterColorBlackBlue,
                    fontSize: 18,
                  ),
                ),
                TextField(
                    decoration: InputDecoration(
                      labelText: 'Nome',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(5.0),
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Lote: ',
                  style: TextStyle(
                    color: AppColors.letterColorBlackBlue,
                    fontSize: 18,
                  ),
                ),
                TextField(
                    decoration: InputDecoration(
                      labelText: 'Lote',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(5),
                    ),
                  ),

              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Quantidade: ',
                  style: TextStyle(
                    color: AppColors.letterColorBlackBlue,
                    fontSize: 18,
                  ),
                ),
                TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(3),
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Data de Validade(opcional): ',
                  style: TextStyle(
                    color: AppColors.letterColorBlackBlue,
                    fontSize: 18,
                  ),
                ),
                TextField(
                    decoration: InputDecoration(
                      labelText: 'dd/mm/aaaa',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(5),
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Tipo de Produto:',
                  style: TextStyle(
                    color: AppColors.letterColorBlackBlue,
                    fontSize: 18,
                  ),
                ),
                FormField(builder: (FormFieldState state) {
                  return InputDecorator(
                    decoration: InputDecoration(
                      labelText: 'Selecione o tipo de produto',
                      border: OutlineInputBorder(),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        items: ListTipos.map((String value) {
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
                })
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 20.0),
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: AppColors.brandColor1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text('Cadastrar'),
                ),
                SizedBox(width: 55),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: AppColors.letterColorBlackBlue,
                    backgroundColor: AppColors.backgroundColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text('Voltar para Estoque'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}