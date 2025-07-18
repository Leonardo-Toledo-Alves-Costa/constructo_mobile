import 'package:constructo_project/components/stock.dart';
import 'package:constructo_project/components/stock_firebase.dart';
import 'package:constructo_project/utils/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterStockPage extends StatefulWidget {
  const RegisterStockPage({super.key});

  @override
  State<RegisterStockPage> createState() => _RegisterStockPageState();
}

class _RegisterStockPageState extends State<RegisterStockPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final  _stockFirebase = StockFirebase();

  final _nomeController = TextEditingController();
  final _loteController = TextEditingController();
  final _quantidadeController = TextEditingController();
  String? _tipo;
  final _dataValidadeController = TextEditingController();
  final DateTime _dataCadastro = DateTime.now();
  final DateTime _dataEditado = DateTime.now();

  Stock? _stock;
  bool _isEditing = false;

  void _cadastroEstoque() async {
    final nome = _nomeController.text;
    final String loteint = _loteController.text.isNotEmpty ? _loteController.text : '0';
    final String quantidade = _quantidadeController.text.isNotEmpty ? _quantidadeController.text : '0';
    final tipo = _tipo;
    final usuarioEditou = _auth.currentUser?.uid;

    if (nome.isEmpty || loteint == '0' || tipo == null || quantidade == '0') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Preencha todos os campos obrigatórios'),
          backgroundColor: AppColors.alertColor,
        ),
      );
      return;
    }

    final stock = Stock(
      product: nome,
      lote: loteint,
      quantidade: quantidade,
      tipo: tipo,
      dataValidade: _dataValidadeController.text.isNotEmpty ? DateTime.parse(_dataValidadeController.text) : null,
      dataCadastro: _dataCadastro,
      dataEditado: _dataEditado,
      usuarioEditou: usuarioEditou!,
    );

    await _stockFirebase.addStock(stock);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Produto cadastrado com sucesso!'),
        backgroundColor: AppColors.confirmationColor,
      ),
    );

    Navigator.pop(context);
  }

  void _updateStock() async {
    if (_stock == null) return;

    final nome = _nomeController.text;
    final lote = _loteController.text;
    final quantidade = _quantidadeController.text;
    final tipo = _tipo;
    final usuarioEditou = _auth.currentUser?.uid;

    if (nome.isEmpty || lote == '0' || tipo == null || quantidade == '0') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Preencha todos os campos obrigatórios'),
          backgroundColor: AppColors.alertColor,
        ),
      );
      return;
    }

    _stock!.quantidade = quantidade;
    _stock!.tipo = tipo;
    _stock!.dataValidade = _dataValidadeController.text.isNotEmpty ? DateTime.parse(_dataValidadeController.text) : null;
    _stock!.dataEditado = _dataEditado;
    _stock!.usuarioEditou = usuarioEditou!;
    _stock!.product = nome;
    
    await _stockFirebase.updateStock(_stock!);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Produto atualizado com sucesso!'),
        backgroundColor: AppColors.confirmationColor,
      ),
    );

    Navigator.pop(context);
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _stock = ModalRoute.of(context)?.settings.arguments as Stock?;
    if (_stock != null) {
      _isEditing = true;
      _nomeController.text = _stock!.product;
      _loteController.text = _stock!.lote.toString();
      _quantidadeController.text = _stock!.quantidade.toString();
      _dataValidadeController.text = _stock!.dataValidade?.toIso8601String() ?? '';
      _tipo = _stock!.tipo;
    }
  }


  @override
  Widget build(BuildContext context) {
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
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/Logo2.png', height: 50),
        centerTitle: true,
        backgroundColor: AppColors.letterColorLightBlue,
        toolbarHeight: 200,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                _isEditing ? 'Editar no Estoque' : 'Cadastrar no Estoque',
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
                    controller: _nomeController,
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
                    controller: _loteController,
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
                    controller: _quantidadeController,
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
                    controller: _dataValidadeController,
                      decoration: InputDecoration(
                        labelText: 'aaaa-mm-dd',
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
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _tipo,
                          isExpanded: true,
                          hint: Text('Escolha o tipo'),
                          items: tipos.map((String value) {
                            return DropdownMenuItem<String>(
        
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _tipo = newValue;
                            });
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
                      _isEditing ? _updateStock() : _cadastroEstoque();
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: AppColors.brandColor1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text('Cadastrar'),
                  ),
                  SizedBox(width: 45),
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
      ),
    );
  }
}