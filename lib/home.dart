import 'package:flutter/material.dart';

class PantallaHome extends StatelessWidget {
  const PantallaHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inicio')),
      body: const Center(
        child: Text('Bienvenido a la app de tareas'),
      ),
    );
  }
}
