import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Geração de ID único no formato xx.xxx.xxxx
  String gerarIdUnico() {
    final rand = Random();
    String dois = rand.nextInt(90 + 10).toString().padLeft(2, '0');
    String tres = rand.nextInt(900).toString().padLeft(3, '0');
    String quatro = rand.nextInt(9000).toString().padLeft(4, '0');
    return "$dois.$tres.$quatro";
  }

  // Criação de usuário com ID retornado
  Future<String?> registrarUsuario(String email, String senha) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: senha);
      return gerarIdUnico(); // ID retornado
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
