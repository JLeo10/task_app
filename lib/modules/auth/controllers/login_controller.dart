// lib/modules/auth/controllers/login_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_app/data/services/auth_service.dart';

class LoginController extends GetxController {
  final AuthService _authService = AuthService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final RxBool isLoading = false.obs;

  Future<void> login() async {
    isLoading.value = true;
    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Todos los campos son obligatorios.');
      isLoading.value = false;
      return;
    }

    try {
      final userCredential = await _authService.loginUser(email, password);
      if (userCredential != null) {
        Get.snackbar('Éxito', '¡Has iniciado sesión correctamente!');
        // Navegar a la pantalla principal después del inicio de sesión exitoso
        Get.offAllNamed('/home');
      } else {
        Get.snackbar('Error', 'Credenciales incorrectas. Intente de nuevo.');
      }
    } catch (e) {
      Get.snackbar('Error', 'Hubo un problema al iniciar sesión.');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
