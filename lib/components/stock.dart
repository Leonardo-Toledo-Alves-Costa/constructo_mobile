import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:constructo_project/components/product.dart';
import 'package:flutter/material.dart';

class Stock with ChangeNotifier {
  String? id;
  String product;
  String quantidade;
  final String lote;
  DateTime? dataValidade;
  final DateTime dataCadastro;
  DateTime dataEditado;
  String usuarioEditou;
  String tipo;

  Stock({
    required this.product,
    required this.quantidade,
    required this.lote,
    this.dataValidade,
    required this.dataCadastro,
    required this.dataEditado,
    required this.usuarioEditou,
    this.id,
    required this.tipo,
  });

  static DateTime _parseDateTime(dynamic dateData) {
    if (dateData == null) return DateTime.now();

    if (dateData is Timestamp) return dateData.toDate();

    if(dateData.isEmpty || dateData.trim().isEmpty) {
      return DateTime.now();

    }    
    if (dateData is DateTime) return dateData;
    
    if (dateData is String) return DateTime.parse(dateData);
    return DateTime.now();
  }

  factory Stock.fromMap(Map<String, dynamic> data) {
    return Stock(
      id: data['id'] ?? '',
      product: data['produto'] ?? '',
      quantidade: data['quantidade']?.toString() ?? '0',
      lote: data['lote']?.toString() ?? '0',
      dataValidade: data['dataValidade'] != null ? _parseDateTime(data['dataValidade']) : null,
      dataCadastro: data['dataCadastro'] != null ? _parseDateTime(data['dataCadastro']) : DateTime.now(),
      dataEditado: data['dataEditado'] != null ? _parseDateTime(data['dataEditado']) : DateTime.now(),
      usuarioEditou: data['usuarioEditou'] ?? '',
      tipo: data['tipo'] ?? '',
    );
  }
Map<String, dynamic> toMap() {
  return {
    'id': id ?? '',
    'produto': product,
    'quantidade': quantidade,
    'lote': lote,
    'dataValidade': dataValidade?.toIso8601String() ?? '',
    'dataCadastro': dataCadastro.toIso8601String(),
    'dataEditado': dataEditado.toIso8601String(),
    'usuarioEditou': usuarioEditou,
    'tipo': tipo,
  };
}
}
