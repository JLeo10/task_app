import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_app/application/controlador_tareas.dart';
import 'package:task_app/models/subject_model.dart';
import 'package:task_app/models/task_model.dart';

class PantallaTareasPorAsignatura extends StatelessWidget {
  final Asignatura asignatura;

  const PantallaTareasPorAsignatura({super.key, required this.asignatura});

  @override
  Widget build(BuildContext context) {
    final ControladorTareas controlador = Get.put(ControladorTareas(asignatura.id));

    return Scaffold(
      appBar: AppBar(title: Text('Tareas - ${asignatura.nombre}')),
      body: Obx(() {
        if (controlador.estaCargando.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controlador.tareas.isEmpty) {
          return Center(child: Text('No hay tareas para ${asignatura.nombre}'));
        }

        return ListView.builder(
          itemCount: controlador.tareas.length,
          itemBuilder: (context, index) {
            final Tarea tarea = controlador.tareas[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: ListTile(
                title: Text(
                  tarea.titulo,
                  style: TextStyle(
                    decoration: tarea.estaCompletada ? TextDecoration.lineThrough : null,
                  ),
                ),
                subtitle: Text('${tarea.descripcion}\nEntrega: ${DateFormat('dd/MM/yyyy').format(tarea.fechaEntrega)}'),
                isThreeLine: true,
                leading: Checkbox(
                  value: tarea.estaCompletada,
                  onChanged: (valor) async {
                    controlador.marcarComoCompletada(tarea.id);
                  },
                ),
                trailing: PopupMenuButton<String>(
                  onSelected: (value) async {
                    if (value == 'editar') {
                      Get.toNamed('/agregar_editar_tarea', arguments: tarea);
                    } else if (value == 'borrar') {
                      final confirm = await Get.defaultDialog<bool>(
                        title: 'Eliminar',
                        middleText: '¿Borrar tarea?',
                        textConfirm: 'Sí',
                        textCancel: 'No',
                      );
                      if (confirm == true) {
                        controlador.eliminarTarea(tarea.id);
                        controlador.cargarTareas();
                      }
                    }
                  },
                  itemBuilder: (_) => [
                    const PopupMenuItem(value: 'editar', child: Text('Editar')),
                    const PopupMenuItem(value: 'borrar', child: Text('Borrar')),
                  ],
                ),
                onTap: () => Get.toNamed('/detalle_tarea', arguments: tarea),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/agregar_editar_tarea', arguments: asignatura.id),
        child: const Icon(Icons.add),
      ),
    );
  }
}
