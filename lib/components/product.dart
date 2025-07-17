import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  String? id = null;
  String nome;
  String marca;
  String tipo;
  DateTime dataCadastro;
  DateTime dataEditado;
  String? imageUrl;
  String? usuarioEditou;
  String? descricao;


  Product({
    this.id,
    required this.nome,
    required this.marca,
    required this.tipo,
    required this.dataCadastro,
    required this.dataEditado,
    this.descricao,
    this.imageUrl,
    this.usuarioEditou,
  });

  factory Product.fromMap(Map<String, dynamic> data) {
    return Product(
      id: data['id'] ?? '',
      nome: data['nome'],
      marca: data['marca'],
      tipo: data['tipo'],
      dataCadastro: DateTime.parse(data['dataCadastro']),
      dataEditado: DateTime.parse(data['dataEditado']),
      descricao: data['descricao'],
      imageUrl: data['imageUrl'],
      usuarioEditou: data['usuarioEditou'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id ?? '',
      'nome': nome,
      'marca': marca,
      'tipo': tipo,
      'dataCadastro': dataCadastro.toIso8601String(),
      'dataEditado': dataEditado.toIso8601String(),
      'descricao': descricao ?? '',
      'imageUrl': imageUrl,
      'usuarioEditou': usuarioEditou,
    };
  }
}