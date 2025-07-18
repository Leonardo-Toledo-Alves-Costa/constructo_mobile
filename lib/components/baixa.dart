import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:constructo_project/components/stock.dart';
import 'package:flutter/material.dart';

class Baixa with ChangeNotifier{
  final String estoque;
  final String quantidade;
  final DateTime data;
  final String usuario;
  String? id;

  Baixa({
    required this.estoque,
    required this.quantidade,
    required this.data,
    required this.usuario,
    this.id,
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

factory Baixa.fromMap(Map<String, dynamic> data) {
  return Baixa(
    id: data['id'] ?? '',
    estoque: data['estoque'] ?? '',
    quantidade: data['quantidade']?.toString() ?? '0',
    data: DateTime.parse(data['data'] ?? DateTime.now().toString()),
    usuario: data['usuario'] ?? '',
  );
}

Map<String, dynamic> toMap() {
  return {
    'id': id,
    'estoque': estoque,
    'quantidade': quantidade,
    'data': data.toIso8601String(),
    'usuario': usuario,
  };
}
}