// lib/modules/auth/views/register_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_app/modules/auth/controllers/register_controller.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Vinculamos la vista con el controlador
    final RegisterController controller = Get.put(RegisterController());

    return Scaffold(
      appBar: AppBar(title: const Text('Registro de Usuario')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: controller.nameController,
                decoration: const InputDecoration(labelText: 'Nombre'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: controller.emailController,
                decoration: const InputDecoration(
                  labelText: 'Correo Electrónico',
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: controller.passwordController,
                decoration: const InputDecoration(labelText: 'Contraseña'),
                obscureText: true,
              ),
              const SizedBox(height: 32),
              Obx(
                () => controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        onPressed: controller.register,
                        child: const Text('Registrar'),
                      ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text('¿Ya tienes una cuenta? Inicia sesión aquí.'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
