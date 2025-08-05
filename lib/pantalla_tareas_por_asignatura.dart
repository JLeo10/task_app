import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_app/application/controlador_tareas.dart';
import 'package:task_app/models/subject_model.dart';

class PantallaTareasPorAsignatura extends StatelessWidget {
  final Asignatura asignatura;

  const PantallaTareasPorAsignatura({super.key, required this.asignatura});

  @override
  Widget build(BuildContext context) {
    // inyecta controlador de tareas para asignatura
    final ControladorTareas controlador = Get.put(ControladorTareas(asignatura.id));

    return Scaffold(
      appBar: AppBar(title: Text('Tareas de ${asignatura.nombre}')),
      body: Obx(() {
        if (controlador.estaCargando.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controlador.tareas.isEmpty) {
          return const Center(
            child: Text('No hay tareas para esta asignatura. ¡Agregaaa!'),
          );
        }

        return ListView.builder(
          itemCount: controlador.tareas.length,
          itemBuilder: (context, index) {
            final tarea = controlador.tareas[index];
            return ListTile(
              title: Text(tarea.titulo),
              subtitle: Text(tarea.descripcion),
              trailing: Checkbox(
                value: tarea.estaCompletada,
                onChanged: (valor) {
                  controlador.marcarComoCompletada(tarea.id);
                },
              ),
              onTap: () => Get.toNamed('/detalle_tarea', arguments: tarea),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/agregar_editar_tarea', arguments: asignatura.id),
        child: const Icon(Icons.add),
        tooltip: 'Añadir Tarea',
      ),
    );
  }
}
