import 'dart:io';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_storage_service.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String gerarEmployeeCode() {
    final rand = Random();
    String dois = rand.nextInt(90 + 10).toString().padLeft(2, '0');
    String tres = rand.nextInt(900).toString().padLeft(3, '0');
    String quatro = rand.nextInt(9000).toString().padLeft(4, '0');
    return "$dois.$tres.$quatro";
  }

  Future<File> _getDefaultAvatarFile() async {
    final byteData = await rootBundle.load('assets/images/avatar.png');
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/default_avatar.png');
    await file.writeAsBytes(byteData.buffer.asUint8List());
    return file;
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

      final uid = userCredential.user!.uid;
      final employeeCode = gerarEmployeeCode();

      File imageFile;
      if (imageURL == '1') {
        imageFile = await _getDefaultAvatarFile();
      } else {
        imageFile = File(imageURL);
      }

      final uploadedImageUrl =
          await FirebaseStorageService().uploadUserImage(imageFile, uid);

      if (uploadedImageUrl == null) return null;

      await _firestore.collection('users').doc(uid).set({
        'nome': nome,
        'sobrenome': sobrenome,
        'email': email,
        'imageURL': uploadedImageUrl,
        'employeeCode': employeeCode,
        'role': 'leitor',
        'uid': uid,
        'criado_em': DateTime.now(),
      });

      return employeeCode;
    } catch (e) {
      print('Erro ao criar conta: $e');
      return null;
    }
  }

  Future<bool> loginUsuario(String email, String senha) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: senha);
      return true;
    } catch (e) {
      print('Erro ao fazer login: $e');
      return false;
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
