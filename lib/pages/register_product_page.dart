import 'package:constructo_project/components/product.dart';
import 'package:constructo_project/components/product_firebase.dart';
import 'package:constructo_project/components/product_image_picker.dart';
import 'package:constructo_project/utils/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterProductPage extends StatefulWidget {
  const RegisterProductPage({super.key});

  @override
  State<RegisterProductPage> createState() => _RegisterProductPageState();
}

class _RegisterProductPageState extends State<RegisterProductPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _productFirebase = ProductFirebase();
  final _nomeController = TextEditingController();
  final _marcaController = TextEditingController();
  final _tipoController = TextEditingController();
  final _descricaoController = TextEditingController();
  String _imageUrl = '';
  final DateTime _dataCadastro = DateTime.now();
  final DateTime _dataEditado = DateTime.now();

  Product? _product;
  bool _isEditing = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _product = ModalRoute.of(context)?.settings.arguments as Product?;
    if (_product != null) {
      _isEditing = true;
      _nomeController.text = _product!.nome;
      _marcaController.text = _product!.marca;
      _tipoController.text = _product!.tipo;
      _descricaoController.text = _product!.descricao ?? '';
      _imageUrl = _product!.imageUrl ?? '';
    }
  }

  void _cadastroProduto() async {
    final nome = _nomeController.text;
    final marca = _marcaController.text;
    final tipo = _tipoController.text;
    final descricao = _descricaoController.text;
    final usuarioEditou = _auth.currentUser?.uid;

    if (nome.isEmpty || marca.isEmpty || tipo.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Preencha todos os campos obrigatórios'),
          backgroundColor: AppColors.alertColor,
        ),
      );
      return;
    }

    final product = Product(
      nome: nome,
      marca: marca,
      tipo: tipo,
      dataCadastro: _dataCadastro,
      dataEditado: _dataEditado,
      descricao: descricao,
      imageUrl: _imageUrl,
      usuarioEditou: usuarioEditou!,
    );

    await _productFirebase.addProduct(product);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Produto cadastrado com sucesso!'),
        backgroundColor: AppColors.confirmationColor,
      ),
    );

    Navigator.pop(context);
  }

  void _updateProduct() async {
    if (_product == null) return;

    final nome = _nomeController.text;
    final marca = _marcaController.text;
    final tipo = _tipoController.text;
    final descricao = _descricaoController.text;
    final usuarioEditou = _auth.currentUser?.uid;

    if (nome.isEmpty || marca.isEmpty || tipo.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Preencha todos os campos obrigatórios'),
          backgroundColor: AppColors.alertColor,
        ),
      );
      return;
    }

    _product!.nome = nome;
    _product!.marca = marca;
    _product!.tipo = tipo;
    _product!.descricao = descricao;
    _product!.imageUrl = _imageUrl;
    _product!.usuarioEditou = usuarioEditou;

    await _productFirebase.updateProduct(_product!);

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
  Widget build(BuildContext context) {
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
                _isEditing ? 'Editar Produto' : 'Cadastrar Produto',
                style: TextStyle(
                  color: Color(0xFF061D3D),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ProductImagePicker(
            imageUrl: _imageUrl,
            onImagePick: (image) {
              setState(() {
                _imageUrl = image.path;
              });
            },
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
                      hintText: 'Nome',
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
                  Text('Marca:',
                    style: TextStyle(
                      color: AppColors.letterColorBlackBlue,
                      fontSize: 18,
                    ),
                  ),
                  TextField(
                      controller: _marcaController,
                      decoration: InputDecoration(
                        hintText: 'Marca',
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
                    
                    var tipos = [
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
                          value: _tipoController.text.isEmpty ? null : _tipoController.text,
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
                              _tipoController.text = newValue ?? '';
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
              padding: const EdgeInsets.symmetric(horizontal: 35.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Descrição do Produto(Opcional):',
                    style: TextStyle(
                      color: AppColors.letterColorBlackBlue,
                      fontSize: 18,
                    ),
                  ),
                  TextField(
                    controller: _descricaoController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: 'Descrição',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(5.0),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 20.0),
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _isEditing ? _updateProduct() : _cadastroProduto();
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
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
