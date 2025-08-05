import 'package:flutter/material.dart';
import 'package:get/get.dart';

// KAT: Esta es una pantalla temporal para el Login.
// Tu trabajo es reemplazar el contenido de este widget `build` con tu diseño.
// La lógica de navegación (el `onPressed`) ya está conectada.
class PantallaLogin extends StatelessWidget {
  const PantallaLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: ElevatedButton(
          // Este botón simula un inicio de sesión exitoso.
          onPressed: () => Get.offAllNamed('/home'),
          child: const Text('Ir a Home'),
        ),
      ),
    );
  }
}
