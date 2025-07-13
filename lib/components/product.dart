import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  String nome;
  String marca;
  final String tipo;
  final DateTime dataCadastro;
  DateTime dataEditado;
  String? descricao;


  Product({
    required this.nome,
    required this.marca,
    required this.tipo,
    required this.dataCadastro,
    required this.dataEditado,
    this.descricao,
  });
}