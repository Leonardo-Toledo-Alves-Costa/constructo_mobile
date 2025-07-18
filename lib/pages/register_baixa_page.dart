import 'package:constructo_project/components/baixa.dart';
import 'package:constructo_project/components/baixa_firebase.dart';
import 'package:constructo_project/components/stock.dart';
import 'package:constructo_project/components/stock_list_tile.dart';
import 'package:constructo_project/utils/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterBaixaPage extends StatefulWidget {
  const RegisterBaixaPage({super.key});

  @override
  State<RegisterBaixaPage> createState() => _RegisterBaixaPageState();
}

class _RegisterBaixaPageState extends State<RegisterBaixaPage> {  
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _baixaFirebase = BaixaFirebase();
  var selected;
  Stock selectedStock = Stock(
    id: '',
    product: '',
    quantidade: '0',
    dataCadastro: DateTime.now(),
    lote: '0',
    dataEditado: DateTime.now(),
    tipo: 'Baixa',
    usuarioEditou: '',
    dataValidade: DateTime.now(),
  );

    void _cadastroBaixa() async {
      if (selected == null || selected == 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Selecione pelo menos um produto para registrar a baixa.'),
            backgroundColor: AppColors.alertColor,
          ),
        );
        return;
      }
      final estoque = selectedStock.product;
      final quantidade = selectedStock.quantidade;
      final data = DateTime.now();
      final usuario = _auth.currentUser?.uid;

      final baixa = Baixa(
        estoque: estoque,
        quantidade: quantidade,
        data: data,
        usuario: usuario ?? '',
      );

      await _baixaFirebase.addBaixa(baixa);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$selected Baixa Registrada com sucesso!'),
          backgroundColor: AppColors.brandColor0,
        ),
      );
      Navigator.of(context).pop();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/Logo.png', height: 40),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.person_pin, size: 35,),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Text(
              'Registrar Baixa',
              style: TextStyle(
                color: AppColors.letterColorBlackBlue,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 20),
          Expanded(child: StockListTile(
            allowSelection: true, 
            onSelectionChanged: (selectedStocks) {
              setState(() {
                selected = selectedStocks.length;
                selectedStock = (selectedStocks.isNotEmpty ? selectedStocks[0] : null)!;

              });
            },
          )),
          SizedBox(height: 20),
          Row(
            children: [
              SizedBox(width: 10),
              Text('$selected produtos selecionados',
                style: TextStyle(
                  color: AppColors.letterColorBlackBlue,
                  fontSize: 16,
                ),
              ),
              SizedBox(width: 25),
              ElevatedButton(
                onPressed: () {
                  _cadastroBaixa();
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, 
                  backgroundColor: AppColors.brandColor0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text('Registrar Baixa'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}