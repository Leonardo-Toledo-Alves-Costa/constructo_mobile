import 'package:constructo_project/components/product.dart';
import 'package:flutter/material.dart';

class Stock with ChangeNotifier {
  final Product product;
  int quantidade;
  final int lote;
  DateTime? dataValidade;
  final DateTime dataCadastro;
  DateTime dataEditado;

  Stock({
    required this.product,
    required this.quantidade,
    required this.lote,
    this.dataValidade,
    required this.dataCadastro,
    required this.dataEditado,
  });
}