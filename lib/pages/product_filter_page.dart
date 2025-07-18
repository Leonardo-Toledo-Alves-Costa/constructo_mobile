import 'package:constructo_project/utils/app_colors.dart';
import 'package:flutter/material.dart';

class ProductFilterPage extends StatefulWidget {
  final Function(String? tipo, String? marca, String? dataDe, String? dataAte)? onFilter;
  const ProductFilterPage({super.key, required this.onFilter});

  @override
  State<ProductFilterPage> createState() => _ProductFilterPageState();
}

class _ProductFilterPageState extends State<ProductFilterPage> {
  String? _selectedTipo;
  final _marcaController = TextEditingController();
  final _dataDeController = TextEditingController();
  final _dataAteController = TextEditingController();
        final List<String> tipos = [
                      'Cimento, Argamassa e Concreto',
                      'Tijolos e Blocos',
                      'Ferragens e Metais',
                      'Ferramentas e Equipamentos',
                      'Hidráulica',
                      'Tintas',
                      'Pisos e Revestimentos',
                      'Elétrica',
                      'Madeiras',
    ];

  @override
  Widget build(BuildContext context) {
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
                    value: _selectedTipo,
                    isExpanded: true,
                    hint: Text('Selecione o tipo'),
                    items: tipos.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                      );
                      }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedTipo = newValue;
                      });
                    },
                  ),
                ),
              );
            }),
            SizedBox(height: 20),
            Text('Marca',
              style: TextStyle(
                color: AppColors.letterColorBlackBlue,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _marcaController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                contentPadding: EdgeInsets.all(5),
                hintText: 'Marca',
              ),
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
                    controller: _dataDeController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      contentPadding: EdgeInsets.all(5),
                      hintText: 'aaaa-mm-dd',
                    ),
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
                    controller: _dataAteController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      contentPadding: EdgeInsets.all(5),
                      hintText: 'aaaa-mm-dd',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 350),
            Row(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.brandColor1,
                    fixedSize: Size(double.infinity, 50),
                  ),
                  onPressed: () {
                    widget.onFilter!(
                      _selectedTipo,
                      _marcaController.text,
                      _dataDeController.text,
                      _dataAteController.text,
                    );
                      Navigator.pop(context);
                  },
                  child: Text('Aplicar Filtros', 
                    style: TextStyle(
                      color: AppColors.backgroundColor,
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(width: 50),
                ElevatedButton(onPressed: () {
                  _marcaController.clear();
                  _dataDeController.clear();
                  _selectedTipo = null;
                  _dataAteController.clear();
                  widget.onFilter!(null, null, null, null);
                  Navigator.pop(context);
                },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.backgroundColor,
                    fixedSize: Size(double.infinity, 50),
                  ), 
                child: Text('Limpar Filtros'),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}