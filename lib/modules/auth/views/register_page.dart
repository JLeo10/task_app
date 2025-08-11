import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_app/modules/auth/controllers/auth_controller.dart';
import 'package:task_app/shared/widgets/custom_textfield.dart';
import 'package:task_app/shared/widgets/primary_button.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController c = Get.put(AuthController());
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(title: const Text('Registro')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              CustomTextField(
                controller: c.nombreController,
                label: 'Nombre',
                validator: c.validarNombre,
              ),
              const SizedBox(height: 12),
              CustomTextField(
                controller: c.emailController,
                label: 'Email',
                keyboardType: TextInputType.emailAddress,
                validator: c.validarEmail,
              ),
              const SizedBox(height: 12),
              CustomTextField(
                controller: c.passwordController,
                label: 'Contraseña',
                obscureText: true,
                validator: c.validarPassword,
              ),
              const SizedBox(height: 12),
              CustomTextField(
                controller: c.confirmarController,
                label: 'Confirmar contraseña',
                obscureText: true,
                validator: c.validarConfirmar,
              ),
              const SizedBox(height: 20),
              Obx(() => PrimaryButton(
                    text: c.isLoading.value ? 'Registrando...' : 'Registrarse',
                    onPressed: c.isLoading.value
                        ? null
                        : () {
                            if (formKey.currentState?.validate() ?? false) {
                              c.register();
                            }
                          },
                  )),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => Get.back(),
                child: const Text('¿Ya tienes una cuenta? Inicia sesión'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
