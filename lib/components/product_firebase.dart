import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:constructo_project/components/product.dart';

class ProductFirebase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addProduct(Product product) async {
    try {
      print('Starting to add product...');
      print('Product data: ${product.nome}, ${product.marca}, ${product.tipo}');

        Map<String, dynamic> productData = {
        'nome': product.nome,
        'marca': product.marca,
        'tipo': product.tipo,
        'dataCadastro': product.dataCadastro.toIso8601String(),
        'dataEditado': product.dataEditado.toIso8601String(),
        'descricao': product.descricao ?? '',
        'imageUrl': product.imageUrl,
        'usuarioEditou': product.usuarioEditou,
      };
      print('Product data map: $productData');
      DocumentReference docRef = await _firestore.collection('produtos').add(productData);
            print('Product added successfully with ID: ${docRef.id}');

    } catch (e) {
      print('Error adding product: $e');
    }
  }

  Future<void> updateProduct(Product product) async {
    try {
      await _firestore.collection('produtos').doc(product.id).update(product.toMap());
    } catch (e) {
      print('Error updating product: $e');
    }
  }

  Stream<List<Product>> get productStream {
    return _firestore.collection('produtos').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data();
        data['id'] = doc.id;
        return Product.fromMap(data);
      }).toList();
    });
  }
}