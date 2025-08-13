// lib/modules/asignaturas/views/pantalla_home.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_app/application/controlador_asignaturas.dart';
import 'package:task_app/models/asignaturas_model.dart';
import 'package:task_app/modules/auth/controllers/auth_controller.dart';

class PantallaHome extends StatelessWidget {
  const PantallaHome({super.key});

  @override
  Widget build(BuildContext context) {
    final AsignaturaController controlador = Get.put(AsignaturaController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Asignaturas'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Cerrar sesión',
            onPressed: () {
              // CORRECCIÓN: Usamos Get.find() para obtener la instancia existente
              final AuthController authController = Get.find<AuthController>();
              authController.signOut();
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controlador.estaCargando.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controlador.asignaturas.isEmpty) {
          return const Center(child: Text('No hay asignaturas. ¡Agrega una!'));
        }
        return ListView.builder(
          itemCount: controlador.asignaturas.length,
          itemBuilder: (context, index) {
            final asignatura = controlador.asignaturas[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: ListTile(
                title: Text(asignatura.nombre),
                onTap: () {
                  if (asignatura.id.isNotEmpty) {
                    Get.toNamed(
                      '/tareas_por_asignatura',
                      arguments: asignatura,
                    );
                  } else {
                    Get.snackbar(
                      'Error',
                      'La asignatura no tiene un ID válido.',
                    );
                  }
                },
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => _mostrarDialogoGuardarAsignatura(
                        context,
                        controlador,
                        asignatura: asignatura,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () =>
                          controlador.eliminarAsignatura(asignatura.id),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _mostrarDialogoGuardarAsignatura(context, controlador),
        tooltip: 'Añadir Asignatura',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _mostrarDialogoGuardarAsignatura(
    BuildContext context,
    AsignaturaController controlador, {
    Asignatura? asignatura,
  }) {
    final TextEditingController textController = TextEditingController(
      text: asignatura?.nombre ?? '',
    );
    final esEdicion = asignatura != null;

    Get.defaultDialog(
      title: esEdicion ? 'Editar Asignatura' : 'Nueva Asignatura',
      content: TextField(
        controller: textController,
        decoration: const InputDecoration(labelText: 'Nombre de la asignatura'),
        autofocus: true,
      ),
      confirm: ElevatedButton(
        onPressed: () {
          if (textController.text.isNotEmpty) {
            if (esEdicion) {
              controlador.actualizarAsignatura(
                asignatura.id,
                textController.text,
              );
            } else {
              controlador.agregarAsignatura(textController.text);
            }
            Get.back();
          }
        },
        child: const Text('Guardar'),
      ),
      cancel: TextButton(
        onPressed: () => Get.back(),
        child: const Text('Cancelar'),
      ),
    );
  }
}
