import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_app/application/controlador_tareas.dart';
import 'package:task_app/config/theme.dart';
import 'package:task_app/models/asignaturas_model.dart';
import 'package:task_app/shared/widgets/custom_checkbox.dart';
import 'package:task_app/shared/widgets/glass_card.dart';

// pantalla que muestra las tareas de una asignatura especifica
class PantallaTareasPorAsignatura extends StatelessWidget {
  const PantallaTareasPorAsignatura({super.key});

  @override
  Widget build(BuildContext context) {
    final Asignatura? asignatura = Get.arguments;

    // manejo de error si no se recibe una asignatura
    if (asignatura == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(
          child: Text('No se pudo cargar la asignatura. Intente de nuevo.'),
        ),
      );
    }

    final TareaController controlador = Get.put(TareaController());
    controlador.cargarTareasPorAsignatura(asignatura.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(asignatura.nombre, style: Theme.of(context).textTheme.titleLarge),
        backgroundColor: AppColors.background.withAlpha((255 * 0.8).round()), // usando withAlpha en lugar de withOpacity
        elevation: 0,
      ),
      body: Obx(() {
        if (controlador.estaCargando.value) {
          return const Center(child: CircularProgressIndicator(color: AppColors.primary));
        }
        if (controlador.tareas.isEmpty) {
          return const Center(child: Text('No hay tareas. ¡Añade una!'));
        }
        // lista de tareas con el nuevo diseno
        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          itemCount: controlador.tareas.length,
          itemBuilder: (context, index) {
            final tarea = controlador.tareas[index];
            // el estilo del texto cambia si la tarea esta completada
            final textStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(
                  decoration: tarea.estaCompletada ? TextDecoration.lineThrough : TextDecoration.none,
                  color: tarea.estaCompletada ? AppColors.textSecondary : AppColors.textPrimary,
                );

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: GlassCard(
                child: InkWell(
                  onTap: () => Get.toNamed('/agregar_editar_tarea', arguments: tarea),
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                    child: Row(
                      children: [
                        // nuestro checkbox personalizado
                        CustomCheckbox(
                          value: tarea.estaCompletada,
                          onChanged: (value) => controlador.marcarComoCompletada(tarea.id, value),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(tarea.titulo, style: textStyle),
                              if (tarea.descripcion.isNotEmpty)
                                Text(
                                  tarea.descripcion,
                                  style: textStyle?.copyWith(fontSize: 12, color: AppColors.textSecondary),
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.chevron_right_rounded, color: AppColors.textSecondary),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }),
      // boton flotante para anadir nuevas tareas
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/agregar_editar_tarea', arguments: asignatura),
        tooltip: 'Añadir Tarea',
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: AppColors.background),
      ),
    );
  }
}
