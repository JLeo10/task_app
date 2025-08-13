// lib/application/controlador_tareas.dart
import 'package:get/get.dart';
import 'package:task_app/data/services/firebase_service.dart';
import 'dart:async';
import 'package:task_app/models/tarea_model.dart';

class TareaController extends GetxController {
  // Ahora el controlador requiere el id de la asignatura para inicializarse
  final String asignaturaId;
  TareaController({required this.asignaturaId});

  final FirebaseService _firebaseService = FirebaseService();
  var tareas = <Tarea>[].obs;
  var estaCargando = true.obs;

  StreamSubscription<List<Tarea>>? _tareasSubscription;

  @override
  void onInit() {
    super.onInit();
    estaCargando(true);
    print('Cargando tareas para la asignatura con ID: $asignaturaId');

    _tareasSubscription?.cancel();
    _tareasSubscription = _firebaseService
        .getTareasStreamPorAsignatura(asignaturaId)
        .listen(
          (data) {
            tareas.assignAll(data);
            estaCargando(false);
          },
          onError: (error) {
            estaCargando(false);
            Get.snackbar('Error', 'No se pudieron cargar las tareas: $error');
          },
        );
  }

  @override
  void onClose() {
    _tareasSubscription?.cancel();
    super.onClose();
  }

  // --- Métodos de escritura (CRUD) ---

  void agregarTarea(Tarea nuevaTarea) async {
    try {
      // El servicio ya sabe el id de la asignatura por la tarea
      await _firebaseService.agregarTarea(nuevaTarea);
      Get.snackbar('Éxito', 'Tarea agregada correctamente.');
    } catch (e) {
      Get.snackbar('Error', 'No se pudo agregar la tarea.');
    }
  }

  void actualizarTarea(Tarea tareaActualizada) async {
    try {
      // El servicio ya sabe el id de la asignatura por la tarea
      await _firebaseService.actualizarTarea(tareaActualizada);
      Get.snackbar('Éxito', 'Tarea actualizada correctamente.');
    } catch (e) {
      Get.snackbar('Error', 'No se pudo actualizar la tarea.');
    }
  }

  void eliminarTarea(String idTarea) async {
    try {
      // Usamos el idAsignatura que ya tiene el controlador
      await _firebaseService.eliminarTarea(asignaturaId, idTarea);
      Get.snackbar('Éxito', 'Tarea eliminada correctamente.');
    } catch (e) {
      Get.snackbar('Error', 'No se pudo eliminar la tarea.');
    }
  }

  void marcarComoCompletada(String tareaId, bool? valor) async {
    try {
      final tarea = tareas.firstWhereOrNull((t) => t.id == tareaId);
      if (tarea != null) {
        final tareaActualizada = tarea.copyWith(estaCompletada: valor ?? false);
        await _firebaseService.actualizarTarea(tareaActualizada);
        Get.snackbar('Éxito', 'Estado de la tarea actualizado.');
      }
    } catch (e) {
      Get.snackbar('Error', 'No se pudo actualizar el estado de la tarea.');
    }
  }
}
