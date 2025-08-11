import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final nombreController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmarController = TextEditingController();

  final isLoading = false.obs;

  String? validarNombre(String? value) {
    if (value == null || value.trim().isEmpty) return 'El nombre es obligatorio';
    if (value.trim().length < 3) return 'Mínimo 3 caracteres';
    return null;
  }

  String? validarEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'El email es obligatorio';
    final regex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}");
    if (!regex.hasMatch(value.trim())) return 'Email inválido';
    return null;
  }

  String? validarPassword(String? value) {
    if (value == null || value.isEmpty) return 'La contraseña es obligatoria';
    if (value.length < 8) return 'Mínimo 8 caracteres';
    final hasLetter = value.contains(RegExp(r'[A-Za-z]'));
    final hasDigit = value.contains(RegExp(r'\d'));
    if (!hasLetter || !hasDigit) return 'Debe contener letras y números';
    return null;
  }

  String? validarConfirmar(String? value) {
    if (value == null || value.isEmpty) return 'Confirme la contraseña';
    if (value != passwordController.text) return 'Las contraseñas no coinciden';
    return null;
  }

  Future<void> register() async {
    isLoading(true);
    await Future.delayed(const Duration(milliseconds: 600));
    isLoading(false);
    Get.snackbar('Registro', 'Usuario registrado correctamente');
    Get.offAllNamed('/home');
  }

  Future<void> login() async {
    isLoading(true);
    await Future.delayed(const Duration(milliseconds: 600));
    isLoading(false);
    if (emailController.text.contains('@') && passwordController.text.length >= 6) {
      Get.offAllNamed('/home');
    } else {
      Get.snackbar('Error', 'Credenciales inválidas');
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
