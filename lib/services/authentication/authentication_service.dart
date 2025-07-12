import 'dart:io';
import 'package:constructo_project/models/user.dart';
abstract class AuthenticationService {
  User get currentUser;

  Stream<User?> get userChanges;

  Future<void> signUp(String nome, String email, String password, File? image);
  Future<void> login(String email, String password);
  Future<void> logout();

    factory AuthenticationService(){
    return AuthFirebaseService();
  }
}