import 'package:flutter/material.dart';
import 'package:get/get.dart';

//KAT: Esta es una pantalla temporal para el Login mmientras termina lo suyo
//reemplazar el contenido de este build con tu diseño
//lalógica de navegación (el `onPressed`) ya está conectada
class PantallaLogin extends StatelessWidget {
  const PantallaLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: ElevatedButton(
          // boton simula inicio de sesion
          onPressed: () => Get.offAllNamed('/home'),
          child: const Text('Ir a Home'),
        ),
      ),
    );
  }
}
