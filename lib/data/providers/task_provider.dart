import 'package:task_app/models/task_model.dart';

// Este provider maneja toda la lógica de datos para las tareas
// LEO: conectar estos métodos con GetStorage
class ProveedorTareas {
  // LEO: Reemplazar  lista con llamadas a GetStorage
  final List<Tarea> _tareas = [
    Tarea(
      id: '1',
      idAsignatura: '1',
      titulo: 'Hacer ensalada de mango',
      descripcion: 'Preparar una deliciosa ensalada de mango.',
      fechaEntrega: DateTime.now().add(const Duration(days: 1)),
    ),
  ];

  //obtiene tareas de una asignatura específica
  Future<List<Tarea>> obtenerTareasPorAsignatura(String idAsignatura) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _tareas
        .where((tarea) => tarea.idAsignatura == idAsignatura)
        .toList();
  }

  //agrega nueva tarea
  Future<Tarea> agregarTarea(Tarea tarea) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final nuevaTarea = tarea;
    nuevaTarea.id = DateTime.now().toString();
    _tareas.add(nuevaTarea);
    return nuevaTarea;
  }

  //actualiza tarea existente
  Future<void> actualizarTarea(Tarea tarea) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final index = _tareas.indexWhere((t) => t.id == tarea.id);
    if (index != -1) {
      _tareas[index] = tarea;
    }
  }

  //elimina tarea
  Future<void> eliminarTarea(String idTarea) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _tareas.removeWhere((t) => t.id == idTarea);
  }

  //cambia estado de completado de tarea
  Future<void> marcarComoCompletada(String idTarea) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final index = _tareas.indexWhere((t) => t.id == idTarea);
    if (index != -1) {
      _tareas[index].estaCompletada = !_tareas[index].estaCompletada;
    }
  }
}
