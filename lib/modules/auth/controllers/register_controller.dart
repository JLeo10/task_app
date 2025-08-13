// lib/modules/auth/controllers/register_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_app/data/services/auth_service.dart';

class RegisterController extends GetxController {
  final AuthService _authService = AuthService();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final RxBool isLoading = false.obs;

  Future<void> register() async {
    isLoading.value = true;
    final String name = nameController.text.trim();
    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Todos los campos son obligatorios.');
      isLoading.value = false;
      return;
    }

    try {
      await _authService.registerUser(email, password, name);
      Get.snackbar('Éxito', 'Usuario registrado correctamente.');
      // Navegar a la pantalla principal después del registro exitoso
      Get.offAllNamed('/home');
    } catch (e) {
      Get.snackbar('Error', 'Hubo un problema al registrar el usuario.');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
