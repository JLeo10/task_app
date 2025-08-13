// lib/modules/tasks/views/pantalla_tareas_por_asignatura.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_app/application/controlador_tareas.dart';
import 'package:task_app/models/asignaturas_model.dart';

class PantallaTareasPorAsignatura extends StatelessWidget {
  const PantallaTareasPorAsignatura({super.key});

  @override
  Widget build(BuildContext context) {
    final Asignatura? asignatura = Get.arguments;

    if (asignatura == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(
          child: Text('No se pudo cargar la asignatura. Intente de nuevo.'),
        ),
      );
    }

    // CORRECCIÓN: Inicializamos el controlador y le pasamos el id de la asignatura
    final TareaController controlador = Get.put(
      TareaController(asignaturaId: asignatura.id),
    );

    return Scaffold(
      appBar: AppBar(title: Text(asignatura.nombre)),
      body: Obx(() {
        if (controlador.estaCargando.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controlador.tareas.isEmpty) {
          return const Center(
            child: Text('No hay tareas para esta asignatura. ¡Añade una!'),
          );
        }
        return ListView.builder(
          itemCount: controlador.tareas.length,
          itemBuilder: (context, index) {
            final tarea = controlador.tareas[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: ListTile(
                title: Text(tarea.titulo),
                subtitle: Text(tarea.descripcion),
                trailing: Checkbox(
                  value: tarea.estaCompletada,
                  onChanged: (bool? value) {
                    controlador.marcarComoCompletada(tarea.id, value);
                  },
                ),
                onTap: () {
                  Get.toNamed('/agregar_editar_tarea', arguments: tarea);
                },
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed('/agregar_editar_tarea', arguments: asignatura);
        },
        tooltip: 'Añadir Tarea',
        child: const Icon(Icons.add),
      ),
    );
  }
}
