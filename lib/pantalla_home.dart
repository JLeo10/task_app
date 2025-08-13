import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_app/application/controlador_asignaturas.dart';
import 'package:task_app/config/theme.dart';
import 'package:task_app/models/asignaturas_model.dart';
import 'package:task_app/shared/widgets/custom_textfield.dart';
import 'package:task_app/shared/widgets/glass_card.dart';
import 'package:task_app/shared/widgets/primary_button.dart';
import 'package:task_app/modules/auth/controllers/auth_controller.dart'; // importamos el authcontroller

// pantalla principal que muestra la lista de asignaturas
class PantallaHome extends StatelessWidget {
  const PantallaHome({super.key});

  @override
  Widget build(BuildContext context) {
    final AsignaturaController controlador = Get.put(AsignaturaController());
    final AuthController authController = Get.find<AuthController>(); // obtenemos el authcontroller

    return Scaffold(
      appBar: AppBar(
        title: Text('Mis Asignaturas', style: Theme.of(context).textTheme.titleLarge),
        backgroundColor: AppColors.background.withAlpha((255 * 0.8).round()), // usando withAlpha en lugar de withOpacity
        elevation: 0,
        actions: [
          // boton de cerrar sesion
          IconButton(
            icon: const Icon(Icons.logout_rounded, color: AppColors.textSecondary),
            onPressed: () {
              authController.logout(); // llamamos al metodo logout
            },
            tooltip: 'Cerrar Sesión',
          ),
        ],
      ),
      body: Obx(() {
        // estado de carga
        if (controlador.estaCargando.value) {
          return const Center(child: CircularProgressIndicator(color: AppColors.primary));
        }
        // estado vacio
        if (controlador.asignaturas.isEmpty) {
          return const Center(child: Text('No hay asignaturas. ¡Agrega una!'));
        }
        // lista de asignaturas
        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          itemCount: controlador.asignaturas.length,
          itemBuilder: (context, index) {
            final asignatura = controlador.asignaturas[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: GlassCard(
                child: InkWell(
                  onTap: () {
                    if (asignatura.id.isNotEmpty) {
                      Get.toNamed('/tareas_por_asignatura', arguments: asignatura);
                    } else {
                      Get.snackbar('Error', 'La asignatura no tiene un ID válido.');
                    }
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            asignatura.nombre,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit_rounded, color: AppColors.textSecondary),
                          onPressed: () => _mostrarDialogoGuardarAsignatura(context, controlador, asignatura: asignatura),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline_rounded, color: AppColors.secondary),
                          onPressed: () => controlador.eliminarAsignatura(asignatura.id),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }),
      // boton flotante para anadir nuevas asignaturas
      floatingActionButton: FloatingActionButton(
        onPressed: () => _mostrarDialogoGuardarAsignatura(context, controlador),
        tooltip: 'Añadir Asignatura',
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: AppColors.background),
      ),
    );
  }

  // dialogo personalizado para guardar o editar una asignatura
  void _mostrarDialogoGuardarAsignatura(
    BuildContext context,
    AsignaturaController controlador, {
    Asignatura? asignatura,
  }) {
    final textController = TextEditingController(text: asignatura?.nombre ?? '');
    final esEdicion = asignatura != null;

    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        child: GlassCard(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                esEdicion ? 'Editar Asignatura' : 'Nueva Asignatura',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 24),
              CustomTextField(
                controller: textController,
                label: 'Nombre de la asignatura',
              ),
              const SizedBox(height: 24),
              PrimaryButton(
                text: 'Guardar',
                onPressed: () {
                  if (textController.text.isNotEmpty) {
                    if (esEdicion) {
                      controlador.actualizarAsignatura(asignatura.id, textController.text);
                    } else {
                      controlador.agregarAsignatura(textController.text);
                    }
                    Get.back();
                  }
                },
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () => Get.back(),
                child: Text(
                  'Cancelar',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
