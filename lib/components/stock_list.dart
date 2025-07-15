import 'package:constructo_project/components/stock.dart';
import 'package:flutter/material.dart';

class StockList with ChangeNotifier{
  final List<Stock> _stocks = [];

  List<Stock> get stocks => _stocks;

  StockList(){
    for(final stock in _stocks){
      stock.addListener(() {
        notifyListeners();
      });
    }
  }

  void addStock(Stock stock) {
    _stocks.add(stock);
    notifyListeners();
  }

  void removeStock(Stock stock) {
    _stocks.remove(stock);
    notifyListeners();
  }

  void updateStock(int index, Stock stock) {
    if (index >= 0 && index < _stocks.length) {
      _stocks[index] = stock;
      notifyListeners();
    }
  }

}