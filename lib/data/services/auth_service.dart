// lib/data/services/auth_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_app/models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Método para registrar a un usuario con email y password
  Future<UserCredential?> registerUser(
    String email,
    String password,
    String nombre,
  ) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      // Una vez que el usuario es creado en Auth, guardamos sus datos en Firestore
      if (userCredential.user != null) {
        UserModel newUser = UserModel(
          uid: userCredential.user!.uid,
          nombre: nombre,
          email: email,
        );

        await _firestore
            .collection('users')
            .doc(newUser.uid)
            .set(newUser.toJson());
      }

      return userCredential;
    } on FirebaseAuthException {
      // Manejar errores de Firebase Auth aquí
      return null;
    }
  }

  Future<UserCredential?> loginUser(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException {
      // Manejar errores como usuario no encontrado o contraseña incorrecta
      return null;
    }
  }

  // Otros métodos de autenticación como login, logout, etc.
}
