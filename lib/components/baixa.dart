import 'package:constructo_project/components/stock.dart';
import 'package:flutter/material.dart';

class Baixa with ChangeNotifier{
  final Stock estoque;
  final int quantidade;
  final DateTime data;
  // final Usuario usuario;

  Baixa({
    required this.estoque,
    required this.quantidade,
    required this.data,
  });
}