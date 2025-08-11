import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_app/application/controlador_tareas.dart';
import 'package:task_app/models/subject_model.dart';

class PantallaTareasPorAsignatura extends StatelessWidget {
  const PantallaTareasPorAsignatura({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Recibir la asignatura desde los argumentos de la ruta
    final Asignatura asignatura = Get.arguments;

    // 2. Instanciar el controlador de tareas para esta asignatura específica
    final ControladorTareas controlador = Get.put(
      ControladorTareas(asignatura.id),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(asignatura.nombre), // Título dinámico con el nombre de la asignatura
      ),
      body: Obx(() {
        // 3. Reaccionar al estado de carga
        if (controlador.estaCargando.value) {
          return const Center(child: CircularProgressIndicator());
        }
        // 4. Reaccionar a la lista de tareas
        if (controlador.tareas.isEmpty) {
          return const Center(
            child: Text('No hay tareas para esta asignatura. ¡Añade una!'),
          );
        }
        // 5. Mostrar la lista de tareas
        return ListView.builder(
          itemCount: controlador.tareas.length,
          itemBuilder: (context, index) {
            final tarea = controlador.tareas[index];
            return ListTile(
              title: Text(tarea.titulo),
              subtitle: Text(tarea.descripcion),
              trailing: Checkbox(
                value: tarea.estaCompletada,
                onChanged: (bool? value) {
                  controlador.marcarComoCompletada(tarea.id);
                },
              ),
              onTap: () {
                // TODO: Navegar a la pantalla de detalle de la tarea
                // Get.toNamed('/detalle_tarea', arguments: tarea);
              },
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Navegar a la pantalla de agregar/editar tarea
          // Get.toNamed('/agregar_editar_tarea', arguments: {'idAsignatura': asignatura.id});
        },
        tooltip: 'Añadir Tarea',
        child: const Icon(Icons.add),
      ),
    );
  }
}