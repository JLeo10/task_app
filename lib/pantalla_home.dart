import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_app/application/controlador_tareas.dart';
import 'package:task_app/models/task_model.dart';

// ¡Hola, Kat! Esta es la pantalla principal por ahora.
// Cuando tengas el diseño final, reemplazas esto con tu magia.
// El botón de '+' ya funciona para añadir tareas, ¡no lo toques! ;)
class PantallaHome extends StatelessWidget {
  const PantallaHome({super.key});

  @override
  Widget build(BuildContext context) {
    // Aquí metemos el controlador de tareas. Usamos '1' como ID de asignatura de prueba.
    // Get.put es listo, se asegura de que no creemos el mismo controlador dos veces.
    final ControladorTareas controlador = Get.put(ControladorTareas('1'));

    return Scaffold(
      appBar: AppBar(title: const Text('Mis Tareas')),
      body: Obx(() {
        // Obx es como un chismoso, se entera si los datos cambian y redibuja el widget.
        if (controlador.estaCargando.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controlador.tareas.isEmpty) {
          return const Center(
            child: Text('No hay tareas. ¡Añade una!'),
          );
        }

        // Kat, aquí va la chicha. Cambia este ListView por tu diseño molón.
        // Toda la info que necesitas está en `controlador.tareas`.
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
      // Este es el botón flotante para añadir tareas nuevas.
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/agregar_editar_tarea'),
        child: const Icon(Icons.add),
        tooltip: 'Añadir Tarea', // Un mensajito de ayuda por si alguien no sabe para qué es el botón.
      ),
    );
  }
}
