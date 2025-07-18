import 'package:constructo_project/components/drawer.dart';
import 'package:constructo_project/components/stock_list_tile.dart';
import 'package:constructo_project/pages/stock_filter_page.dart';
import 'package:constructo_project/utils/app_colors.dart';
import 'package:flutter/material.dart';

class StockPage extends StatefulWidget {
  const StockPage({super.key});

  @override
  State<StockPage> createState() => _StockPageState();
}
  int _orderbyTipo = 0;
  int _orderbyLote = 0;
  int _orderbyData = 0;
  int _orderbyQuantidade = 0;
  String? _loteFiltro;
  String? _tipoFiltro;
  String? _dataFiltroDe;
  String? _dataFiltroAte;
  final _nomeController = TextEditingController();

class _StockPageState extends State<StockPage> {

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
                  SizedBox(width: 115),
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
                onChanged: (value) => setState(() {
                  _nomeController.text = value;
                }),
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
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => StockFilterPage(
                        onFilter: (tipo, lote, dataDe, dataAte) {
                          setState(() {
                            _tipoFiltro = tipo;
                            _loteFiltro = lote;
                            _dataFiltroDe = dataDe;
                            _dataFiltroAte = dataAte;
                          });
                        },
                      ),
                    ));
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
                      onChanged: (value) {
                        setState(() {
                          _orderbyData = 0;
                          _orderbyQuantidade = 0;
                          _orderbyLote = 0;
                          _orderbyTipo = 0;

                          if (value == 'Quantidade') {
                            _orderbyQuantidade = 1;
                          } else if (value == 'N° Lote') {
                            _orderbyLote = 1;
                          } else if (value == 'Data de cadastro') {
                            _orderbyData = 1;
                          } else if (value == 'Tipo') {
                            _orderbyTipo = 1;
                          }
                          if (value == 'Quantidade') {
                            _orderbyQuantidade = 1;
                          } else if (value == 'N° Lote') {
                            _orderbyLote = 1;
                          } else if (value == 'Data de cadastro') {
                            _orderbyData = 1;
                          } else if (value == 'Tipo') {
                            _orderbyTipo = 1;
                          }
                        });
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: StockListTile(
              orderbyTipo: _orderbyTipo,
              orderbyNumeroLote: _orderbyLote,
              dataFiltroDe: _dataFiltroDe,
              dataFiltroAte: _dataFiltroAte,
              orderbyData: _orderbyData,
              orderbyQuantidade: _orderbyQuantidade,
              loteFiltro: _loteFiltro,
              tipoFiltro: _tipoFiltro,
              nomeFiltro: _nomeController.text.isNotEmpty ? _nomeController.text : null,
            ),
          ),
        
        ],
      ),
      drawer: DrawerComponent(),
    );
  }
}