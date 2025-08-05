import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_app/application/controlador_asignaturas.dart';
import 'package:task_app/models/subject_model.dart';

class PantallaHome extends StatelessWidget {
  const PantallaHome({super.key});

  @override
  Widget build(BuildContext context) {
    final ControladorAsignaturas controlador = Get.put(
      ControladorAsignaturas(),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Mis Asignaturas')),
      body: Obx(() {
        if (controlador.estaCargando.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controlador.asignaturas.isEmpty) {
          return const Center(child: Text('No hay asignaturas. ¡Agregaaa!'));
        }
        return ListView.builder(
          itemCount: controlador.asignaturas.length,
          itemBuilder: (context, index) {
            final asignatura = controlador.asignaturas[index];
            return ListTile(
              title: Text(asignatura.nombre),
              onTap: () {
                Get.toNamed('/tareas_por_asignatura', arguments: asignatura);
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

  // --- Diálogo para Añadir/Editar Asignatura ---
  void _mostrarDialogoGuardarAsignatura(
    BuildContext context,
    ControladorAsignaturas controlador, {
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
            Get.back(); // cierra dialogo
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
