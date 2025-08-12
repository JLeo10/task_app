import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_app/application/controlador_tareas.dart';
import 'package:task_app/models/tarea_model.dart';

// KAT: Esta es la pantalla para ver los detalles de una tarea
// Aqui mostrar toda la info de la Tarea toa  chula
class PantallaDetalleTarea extends StatelessWidget {
  const PantallaDetalleTarea({super.key});

  @override
  Widget build(BuildContext context) {
    final Tarea tarea = Get.arguments;

    //buscamos el controlador que ya está por ahí
    final TareaController controlador = Get.find<TareaController>();

    return Scaffold(
      appBar: AppBar(
        title: Text(tarea.titulo),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Get.toNamed('/agregar_editar_tarea', arguments: tarea);
            },
          ),
          // Un botoncito para borrar la tarea
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              // Preguntamos antes, por si acaso
              Get.defaultDialog(
                title: 'Eliminar Tarea',
                middleText: '¿Seguro que quieres borrar esta tarea?',
                textConfirm: 'Sí, bórrar',
                textCancel: 'Mejor no',
                onConfirm: () {
                  controlador.eliminarTarea(tarea.id);
                  Get.back(); // cierra el dialogo
                  Get.back(); // yy volvemos a la lista
                },
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(tarea.descripcion, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 16),
                const SizedBox(width: 8),
                Text(
                  'Fecha de entrega: ${DateFormat('dd/MM/yyyy').format(tarea.fechaEntrega)}',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
