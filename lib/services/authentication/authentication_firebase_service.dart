import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Geração de employeeCode no formato xx.xxx.xxxx
  String gerarEmployeeCode() {
    final rand = Random();
    String dois = rand.nextInt(90 + 10).toString().padLeft(2, '0');
    String tres = rand.nextInt(900).toString().padLeft(3, '0');
    String quatro = rand.nextInt(9000).toString().padLeft(4, '0');
    return "$dois.$tres.$quatro";
  }

  Future<String?> registrarUsuarioComFirestore({
    required String nome,
    required String sobrenome,
    required String email,
    required String senha,
    required String imageURL,
  }) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: senha,
      );

      final String employeeCode = gerarEmployeeCode();

      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'nome': nome,
        'sobrenome': sobrenome,
        'email': email,
        'imageURL': imageURL,
        'employeeCode': employeeCode,
        'role': 'leitor', 
        'uid': userCredential.user!.uid,
        'criado_em': DateTime.now(),
      });

      return employeeCode;
    } catch (e) {
      print('Erro ao criar conta: $e');
      return null;
    }
  }

  // Login de usuário
  Future<bool> loginUsuario(String email, String senha) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: senha);
      return true;
    } catch (e) {
      print('Erro ao fazer login: $e');
      return false;
    }
  }

  // Logout
  Future<void> logout() async {
    await _auth.signOut();
  }
}
