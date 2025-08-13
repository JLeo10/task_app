// lib/modules/auth/views/pantalla_login.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
<<<<<<< HEAD
import 'package:task_app/modules/auth/controllers/login_controller.dart';
=======
import 'package:task_app/config/theme.dart';
import 'package:task_app/modules/auth/controllers/auth_controller.dart';
import 'package:task_app/shared/widgets/custom_textfield.dart';
import 'package:task_app/shared/widgets/primary_button.dart';
>>>>>>> f24a15b8ca235d1926d3e2eb88ff5d83bcd8cc7a

// esta es la pantalla para iniciar sesion
class PantallaLogin extends StatelessWidget {
  const PantallaLogin({super.key});

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    // Vinculamos la vista con el controlador
    final LoginController controller = Get.put(LoginController());

    return Scaffold(
      appBar: AppBar(title: const Text('Inicio de Sesión')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
                        onPressed: controller.login,
                        child: const Text('Iniciar Sesión'),
                      ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Get.toNamed('/register');
                },
                child: const Text('¿No tienes una cuenta? Regístrate aquí.'),
              ),
            ],
=======
    // inyectamos el controlador de autenticacion
    final AuthController c = Get.put(AuthController());
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      // el color de fondo se toma del tema global
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // titulo de la pantalla
                  Text(
                    'Bienvenido de Nuevo',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 28),
                  ),
                  const SizedBox(height: 8),
                  // subtitulo
                  Text(
                    'Inicia sesión para continuar con tus tareas',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 40),
                  // campo de texto para el email
                  CustomTextField(
                    controller: c.emailController,
                    label: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    validator: c.validarEmail,
                  ),
                  const SizedBox(height: 16),
                  // campo de texto para la contrasena
                  CustomTextField(
                    controller: c.passwordController,
                    label: 'Contraseña',
                    obscureText: true,
                    validator: (v) => v == null || v.isEmpty ? 'ingrese la contraseña' : null,
                  ),
                  const SizedBox(height: 24),
                  // boton de inicio de sesion con estado de carga
                  Obx(() => PrimaryButton(
                        text: c.isLoading.value ? 'Iniciando...' : 'Iniciar Sesión',
                        onPressed: c.isLoading.value
                            ? null
                            : () {
                                if (formKey.currentState?.validate() ?? false) {
                                  c.login();
                                }
                              },
                      )),
                  const SizedBox(height: 16),
                  // boton para ir a la pantalla de registro
                  TextButton(
                    onPressed: () => Get.toNamed('/register'),
                    child: Text(
                      '¿No tienes cuenta? Regístrate',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.primary, // usamos el color de acento
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                ],
              ),
            ),
>>>>>>> f24a15b8ca235d1926d3e2eb88ff5d83bcd8cc7a
          ),
        ),
      ),
    );
  }
}
