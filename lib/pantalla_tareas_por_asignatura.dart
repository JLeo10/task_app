import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_app/application/controlador_tareas.dart';
import 'package:task_app/config/theme.dart';
import 'package:task_app/models/asignaturas_model.dart';
import 'package:task_app/shared/widgets/custom_checkbox.dart';
import 'package:task_app/shared/widgets/glass_card.dart';
import 'package:task_app/data/services/firebase_service.dart';

class PantallaTareasPorAsignatura extends StatefulWidget {
  final String asignaturaId;

  const PantallaTareasPorAsignatura({super.key, required this.asignaturaId});

  @override
  State<PantallaTareasPorAsignatura> createState() => _PantallaTareasPorAsignaturaState();
}

class _PantallaTareasPorAsignaturaState extends State<PantallaTareasPorAsignatura> {
  late final TareaController tareaController;
  final FirebaseService _firebaseService = FirebaseService();
  Asignatura? asignatura;
  bool isLoadingAsignatura = true;

  @override
  void initState() {
    super.initState();
    tareaController = Get.put(TareaController(asignaturaId: widget.asignaturaId));
    _fetchAsignatura();
  }

  Future<void> _fetchAsignatura() async {
    try {
      asignatura = await _firebaseService.getAsignaturaById(widget.asignaturaId);
      setState(() {
        isLoadingAsignatura = false;
      });
    } catch (e) {
      Get.snackbar('Error', 'No se pudo cargar la asignatura: $e');
      setState(() {
        isLoadingAsignatura = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoadingAsignatura) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (asignatura == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(
          child: Text('No se pudo cargar la asignatura. Intente de nuevo.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(asignatura!.nombre, style: Theme.of(context).textTheme.titleLarge),
        backgroundColor: AppColors.background.withAlpha((255 * 0.8).round()),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today, color: AppColors.textPrimary),
            onPressed: () {
              Get.toNamed('/calendario/${asignatura!.id}');
            },
          ),
          IconButton(
            icon: const Icon(Icons.view_week, color: AppColors.textPrimary),
            onPressed: () {
              Get.toNamed('/vista_semanal/${asignatura!.id}');
            },
          ),
        ],
      ),
      body: Obx(() {
        if (tareaController.estaCargando.value) {
          return const Center(child: CircularProgressIndicator(color: AppColors.primary));
        }
        if (tareaController.tareas.isEmpty) {
          return const Center(child: Text('No hay tareas. ¡Añade una!'));
        }
        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          itemCount: tareaController.tareas.length,
          itemBuilder: (context, index) {
            final tarea = tareaController.tareas[index];
            final textStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(
                  decoration: tarea.estaCompletada ? TextDecoration.lineThrough : TextDecoration.none,
                  color: tarea.estaCompletada ? AppColors.textSecondary : AppColors.textPrimary,
                );

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: GlassCard(
                child: InkWell(
                  onTap: () => Get.toNamed('/agregar_editar_tarea', arguments: {'tarea': tarea, 'asignatura': asignatura}),
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                    child: Row(
                      children: [
                        CustomCheckbox(
                          value: tarea.estaCompletada,
                          onChanged: (value) => tareaController.marcarComoCompletada(tarea.id, value),
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
                        const Icon(Icons.chevron_right_rounded, color: AppColors.textPrimary),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/agregar_editar_tarea', arguments: {'asignatura': asignatura}),
        tooltip: 'Añadir Tarea',
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: AppColors.background),
      ),
    );
  }
}