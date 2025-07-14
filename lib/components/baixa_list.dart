import 'package:constructo_project/components/baixa.dart';
import 'package:flutter/material.dart';

class BaixaList with ChangeNotifier{
  final List<Baixa> _baixas = [];

  List<Baixa> get baixas => _baixas;


  BaixaList(){
    for(final baixa in _baixas){
      baixa.addListener(() {
        notifyListeners();
      });
    }
  }

  void addBaixa(Baixa baixa) {
    _baixas.add(baixa);
    notifyListeners();
  }

  void removeBaixa(Baixa baixa) {
    _baixas.remove(baixa);
    notifyListeners();
  }
}