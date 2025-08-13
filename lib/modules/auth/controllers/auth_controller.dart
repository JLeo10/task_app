import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart'; // importamos firebase auth

// controlador para la autenticacion de usuarios
class AuthController extends GetxController {
  final nombreController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmarController = TextEditingController();

  final isLoading = false.obs;

  // validadores de campos
  String? validarNombre(String? value) {
<<<<<<< HEAD
    if (value == null || value.trim().isEmpty)
      return 'El nombre es obligatorio';
    if (value.trim().length < 3) return 'Mínimo 3 caracteres';
=======
    if (value == null || value.trim().isEmpty) return 'el nombre es obligatorio';
    if (value.trim().length < 3) return 'minimo 3 caracteres';
>>>>>>> f24a15b8ca235d1926d3e2eb88ff5d83bcd8cc7a
    return null;
  }

  String? validarEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'el email es obligatorio';
    final regex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}");
    if (!regex.hasMatch(value.trim())) return 'email invalido';
    return null;
  }

  String? validarPassword(String? value) {
    if (value == null || value.isEmpty) return 'la contraseña es obligatoria';
    if (value.length < 6) return 'minimo 6 caracteres'; // firebase auth requiere 6
    final hasLetter = value.contains(RegExp(r'[A-Za-z]'));
    final hasDigit = value.contains(RegExp(r'\d'));
    if (!hasLetter || !hasDigit) return 'debe contener letras y numeros';
    return null;
  }

  String? validarConfirmar(String? value) {
    if (value == null || value.isEmpty) return 'confirme la contraseña';
    if (value != passwordController.text) return 'las contraseñas no coinciden';
    return null;
  }

  // metodo para registrar un nuevo usuario con firebase
  Future<void> register() async {
    isLoading(true);
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      Get.snackbar('registro exitoso', 'usuario registrado correctamente');
      Get.offAllNamed('/home'); // navegar a home despues del registro
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == 'weak-password') {
        message = 'la contraseña es demasiado debil';
      } else if (e.code == 'email-already-in-use') {
        message = 'el email ya esta en uso';
      } else {
        message = 'error al registrar: ${e.message}';
      }
      Get.snackbar('error de registro', message);
    } catch (e) {
      Get.snackbar('error', 'ocurrio un error inesperado: $e');
    } finally {
      isLoading(false);
    }
  }

  // metodo para iniciar sesion con firebase
  Future<void> login() async {
    isLoading(true);
<<<<<<< HEAD
    await Future.delayed(const Duration(milliseconds: 600));
    isLoading(false);
    if (emailController.text.contains('@') &&
        passwordController.text.length >= 6) {
      Get.offAllNamed('/home');
    } else {
      Get.snackbar('Error', 'Credenciales inválidas');
=======
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      Get.snackbar('inicio de sesion exitoso', 'bienvenido');
      Get.offAllNamed('/home'); // navegar a home despues del login
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == 'user-not-found') {
        message = 'no se encontro usuario con ese email';
      } else if (e.code == 'wrong-password') {
        message = 'contraseña incorrecta';
      } else {
        message = 'error al iniciar sesion: ${e.message}';
      }
      Get.snackbar('error de inicio de sesion', message);
    } catch (e) {
      Get.snackbar('error', 'ocurrio un error inesperado: $e');
    } finally {
      isLoading(false);
    }
  }

  // metodo para cerrar sesion
  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.snackbar('sesion cerrada', 'has cerrado sesion correctamente');
      Get.offAllNamed('/login'); // navegar a login despues de cerrar sesion
    } catch (e) {
      Get.snackbar('error al cerrar sesion', 'no se pudo cerrar sesion: $e');
>>>>>>> f24a15b8ca235d1926d3e2eb88ff5d83bcd8cc7a
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