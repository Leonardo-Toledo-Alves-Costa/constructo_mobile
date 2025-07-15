import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user.dart';

class UserFirebase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<Usuario?> get userStream {
    final userid = _auth.currentUser?.uid;
    if (userid == null) {
      return Stream.value(null);
    }
    else {
      return _firestore.collection('users').doc(userid).snapshots().map((snapshot) {
        if (snapshot.exists) {
          return snapshot.data() != null ? Usuario.fromMap(snapshot.data()!) : null;
        }
        return null;
      });
    }
  }

}