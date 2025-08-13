// lib/modules/auth/controllers/auth_controller.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final RxBool isLoading = false.obs;

  final TextEditingController nombreController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmarController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    _auth.authStateChanges().listen((User? user) {
      if (user == null) {
        Get.offAllNamed('/auth');
      } else {
        Get.offAllNamed('/home');
      }
    });
  }

  // --- Lógica de validación ---
  String? validarNombre(String? value) {
    if (value == null || value.isEmpty) {
      return 'El nombre no puede estar vacío';
    }
    return null;
  }

  String? validarEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'El email no puede estar vacío';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Ingresa un email válido';
    }
    return null;
  }

  String? validarPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'La contraseña no puede estar vacía';
    }
    if (value.length < 6) {
      return 'La contraseña debe tener al menos 6 caracteres';
    }
    return null;
  }

  String? validarConfirmar(String? value) {
    if (value != passwordController.text) {
      return 'Las contraseñas no coinciden';
    }
    return null;
  }

  // --- Método de registro ---
  Future<void> register() async {
    isLoading(true);
    try {
      final UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          );
      final User? user = userCredential.user;

      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'nombre': nombreController.text,
          'email': user.email,
          'createdAt': FieldValue.serverTimestamp(),
        });
        Get.snackbar('Éxito', '¡Registro exitoso! ¡Bienvenido!');
      }
    } on FirebaseAuthException catch (e) {
      String mensaje = 'Error al registrar el usuario.';
      if (e.code == 'weak-password') {
        mensaje = 'La contraseña es demasiado débil.';
      } else if (e.code == 'email-already-in-use') {
        mensaje = 'Ya existe una cuenta con este correo electrónico.';
      }
      Get.snackbar('Error', mensaje);
    } catch (e) {
      Get.snackbar('Error', 'Ha ocurrido un error inesperado: ${e.toString()}');
    } finally {
      isLoading(false);
    }
  }

  // --- Método de inicio de sesión ---
  Future<void> login() async {
    isLoading(true);
    try {
      await _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      Get.snackbar('Éxito', '¡Sesión iniciada correctamente!');
    } on FirebaseAuthException catch (e) {
      String mensaje = 'Error al iniciar sesión.';
      if (e.code == 'user-not-found') {
        mensaje = 'No se encontró un usuario con este correo electrónico.';
      } else if (e.code == 'wrong-password') {
        mensaje = 'Contraseña incorrecta.';
      }
      Get.snackbar('Error', mensaje);
    } catch (e) {
      Get.snackbar('Error', 'Ha ocurrido un error inesperado: ${e.toString()}');
    } finally {
      isLoading(false);
    }
  }

  // --- Método para Cerrar Sesión ---
  Future<void> signOut() async {
    isLoading(true);
    try {
      await _auth.signOut();
    } catch (e) {
      Get.snackbar('Error', 'No se pudo cerrar la sesión.');
    } finally {
      isLoading(false);
    }
  }

  @override
  void onClose() {
    nombreController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmarController.dispose();
    super.onClose();
  }
}
