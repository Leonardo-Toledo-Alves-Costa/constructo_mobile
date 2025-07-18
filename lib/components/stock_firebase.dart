import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:constructo_project/components/stock.dart';

class StockFirebase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addStock(Stock stock) async {
    try {
      Map<String, dynamic> stockData = stock.toMap();
      DocumentReference docRef = await _firestore.collection('estoque').add(stockData);
    } catch (e) {
      print('Error adding stock: $e');
    }
  }

  Future<void> updateStock(Stock stock) async {
    try {
      await _firestore.collection('estoque').doc(stock.id).update(stock.toMap());
    } catch (e) {
      print('Error updating stock: $e');
    }
  }

  Stream<List<Stock>> get stockStream {
    return _firestore.collection('estoque').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data();
        data['id'] = doc.id;
        return Stock.fromMap(data);
      }).toList();
    });
  }
}