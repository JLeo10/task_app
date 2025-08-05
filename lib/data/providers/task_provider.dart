import 'package:task_app/models/task_model.dart';

// Este provider maneja toda la lógica de datos para las tareas.
// LEO: Tu trabajo es conectar estos métodos con GetStorage.
class ProveedorTareas {
  // Lista en memoria para simular la base de datos.
  // LEO: Reemplazar esta lista con llamadas a GetStorage.
  final List<Tarea> _tareas = [
    Tarea(
      id: '1',
      idAsignatura: '1',
      titulo: 'Hacer la tarea de cálculo',
      descripcion: 'Resolver los ejercicios de la página 50.',
      fechaEntrega: DateTime.now().add(const Duration(days: 2)),
    ),
    Tarea(
      id: '2',
      idAsignatura: '2',
      titulo: 'Leer el capítulo 3 de historia',
      descripcion: 'Resumir las causas de la Primera Guerra Mundial.',
      fechaEntrega: DateTime.now().add(const Duration(days: 5)),
      estaCompletada: true,
    ),
  ];

  // Obtiene las tareas de una asignatura específica.
  Future<List<Tarea>> obtenerTareasPorAsignatura(String idAsignatura) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _tareas.where((tarea) => tarea.idAsignatura == idAsignatura).toList();
  }

  // Agrega una nueva tarea.
  Future<Tarea> agregarTarea(Tarea tarea) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final nuevaTarea = tarea;
    nuevaTarea.id = DateTime.now().toString();
    _tareas.add(nuevaTarea);
    return nuevaTarea;
  }

  // Actualiza una tarea existente.
  Future<void> actualizarTarea(Tarea tarea) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final index = _tareas.indexWhere((t) => t.id == tarea.id);
    if (index != -1) {
      _tareas[index] = tarea;
    }
  }

  // Elimina una tarea.
  Future<void> eliminarTarea(String idTarea) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _tareas.removeWhere((t) => t.id == idTarea);
  }

  // Cambia el estado de completado de una tarea.
  Future<void> marcarComoCompletada(String idTarea) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final index = _tareas.indexWhere((t) => t.id == idTarea);
    if (index != -1) {
      _tareas[index].estaCompletada = !_tareas[index].estaCompletada;
    }
  }
}
