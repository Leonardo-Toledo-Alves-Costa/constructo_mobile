import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:constructo_project/components/baixa.dart';

class BaixaFirebase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addBaixa(Baixa baixa) async {
    try {
      Map<String, dynamic> baixaData = baixa.toMap();
      DocumentReference docRef = await _firestore.collection('baixas').add(baixaData);
    } catch (e) {
      print('Error adding baixa: $e');
    }
  }

  Future<void> updateBaixa(Baixa baixa) async {
    try {
      await _firestore.collection('baixas').doc(baixa.id).update(baixa.toMap());
    } catch (e) {
      print('Error updating baixa: $e');
    }
  }

  Stream<List<Baixa>> get baixaStream {
    return _firestore.collection('baixas').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data();
        data['id'] = doc.id;
        return Baixa.fromMap(data);
      }).toList();
    });
  }
}