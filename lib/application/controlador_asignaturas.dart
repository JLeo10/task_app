import 'package:get/get.dart';
import 'package:task_app/data/services/firebase_service.dart';
import 'package:task_app/models/asignaturas_model.dart';
import 'dart:async';

class AsignaturaController extends GetxController {
  final FirebaseService _firebaseService = FirebaseService();
  var asignaturas = <Asignatura>[].obs;
  var estaCargando = true.obs;

  StreamSubscription<List<Asignatura>>? _asignaturasSubscription;

  @override
  void onInit() {
    super.onInit();
    estaCargando(true);
    _asignaturasSubscription = _firebaseService.getAsignaturasStream().listen(
      (data) {
        asignaturas.assignAll(data);
        if (estaCargando.value) {
          estaCargando(false);
        }
      },
      onError: (error) {
        estaCargando(false);
        Get.snackbar('Error', 'No se pudieron cargar las asignaturas: $error');
      },
    );
  }

  @override
  void onClose() {
    _asignaturasSubscription?.cancel();
    super.onClose();
  }

  void agregarAsignatura(String nombre) async {
    try {
      final nuevaAsignatura = Asignatura(id: '', nombre: nombre);
      await _firebaseService.agregarAsignatura(nuevaAsignatura);
      Get.snackbar('Éxito', 'Asignatura agregada correctamente.');
    } catch (e) {
      Get.snackbar('Error', 'No se pudo agregar la asignatura: $e');
    }
  }

  // Método para actualizar una asignatura existente
  void actualizarAsignatura(String id, String nuevoNombre) async {
    try {
      final asignaturaActualizada = asignaturas.firstWhere((a) => a.id == id);
      await _firebaseService.actualizarAsignatura(
        asignaturaActualizada.copyWith(nombre: nuevoNombre),
      );
      Get.snackbar('Éxito', 'Asignatura actualizada correctamente.');
    } catch (e) {
      Get.snackbar('Error', 'No se pudo actualizar la asignatura: $e');
    }
  }

  // Método para eliminar una asignatura
  void eliminarAsignatura(String id) async {
    try {
      await _firebaseService.eliminarAsignatura(id);
      Get.snackbar('Éxito', 'Asignatura eliminada correctamente.');
    } catch (e) {
      Get.snackbar('Error', 'No se pudo eliminar la asignatura: $e');
    }
  }
}
