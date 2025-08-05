import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_app/application/controlador_tareas.dart';
import 'package:task_app/models/task_model.dart';

// ¡Hola, Kat! Esta es la pantalla para ver los detalles de una tarea.
// Aquí tienes que mostrar toda la info de la `Tarea` de forma chula.
class PantallaDetalleTarea extends StatelessWidget {
  const PantallaDetalleTarea({super.key});

  @override
  Widget build(BuildContext context) {
    // Pillamos la tarea que nos pasaron desde la pantalla anterior.
    final Tarea tarea = Get.arguments;

    // Buscamos el controlador que ya está por ahí.
    final ControladorTareas controlador = Get.find<ControladorTareas>();

    return Scaffold(
      appBar: AppBar(
        title: Text(tarea.titulo),
        actions: [
          // Un botoncito para borrar la tarea.
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              // Preguntamos antes de liarla, por si acaso.
              Get.defaultDialog(
                title: 'Eliminar Tarea',
                middleText: '¿Seguro que quieres borrar esta tarea? No hay vuelta atrás.',
                textConfirm: 'Sí, bórrala',
                textCancel: 'Mejor no',
                onConfirm: () {
                  controlador.eliminarTarea(tarea.id);
                  Get.back(); // Cierra el diálogo
                  Get.back(); // Y volvemos a la lista
                },
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        // Kat, aquí te toca a ti. Monta un diseño guay con esta info.
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tarea.descripcion,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 16),
                const SizedBox(width: 8),
                Text('Fecha de entrega: ${tarea.fechaEntrega.toLocal()}'.split(' ')[0]),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
