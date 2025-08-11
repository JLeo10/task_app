import 'package:get/get.dart';
import 'package:task_app/data/providers/task_provider.dart';
import 'package:task_app/models/task_model.dart';

class ControladorTareas extends GetxController {
  final ProveedorTareas _proveedorTareas = ProveedorTareas();

  final String idAsignatura;

  var tareas = <Tarea>[].obs;
  var estaCargando = true.obs;

  ControladorTareas(this.idAsignatura);

  @override
  void onInit() {
    super.onInit();
    cargarTareas();
  }

  void cargarTareas() async {
    try {
      estaCargando(true);
      var resultado = await _proveedorTareas.obtenerTareasPorAsignatura(idAsignatura);
      tareas.assignAll(resultado);
    } finally {
      estaCargando(false);
    }
  }

  void agregarTarea(Tarea nuevaTarea) async {
    final tareaConAsignatura = nuevaTarea.copyWith(idAsignatura: idAsignatura);
    await _proveedorTareas.agregarTarea(tareaConAsignatura);
    cargarTareas();
  }

  void actualizarTarea(Tarea tareaActualizada) async {
    await _proveedorTareas.actualizarTarea(tareaActualizada);
    cargarTareas();
  }

  void marcarComoCompletada(String idTarea) async {
    await _proveedorTareas.marcarComoCompletada(idTarea);
    cargarTareas();
  }

  void eliminarTarea(String idTarea) async {
    await _proveedorTareas.eliminarTarea(idTarea);
    cargarTareas();
  }
}
