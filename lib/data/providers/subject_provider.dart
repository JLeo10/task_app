import 'package:task_app/models/subject_model.dart';

// Este provider maneja toda la lógica de datos para las asignaturas
// Actualmente usa una lista en memoria, pero está preparado para que
// Leo conecta aquí su lógica de GetStorage
class ProveedorAsignaturas {
  //ahorita en memoria para simular la base de datos
  // LEO: Reemplazar esta lista con llamadas a GetStorage
  final List<Asignatura> _asignaturas = [
    Asignatura(id: '1', nombre: 'Matemáticas'),
    Asignatura(id: '2', nombre: 'Historia'),
  ];

  //obtiene todas las asignaturas
  Future<List<Asignatura>> obtenerTodasLasAsignaturas() async {
    //simula retardo de red
    await Future.delayed(const Duration(milliseconds: 300));
    return _asignaturas;
  }

  //agrega nueva asignatura
  Future<Asignatura> agregarAsignatura(String nombre) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final nuevaAsignatura = Asignatura(id: DateTime.now().toString(), nombre: nombre);
    _asignaturas.add(nuevaAsignatura);
    return nuevaAsignatura;
  }

  //actualiza asignatura existente
  Future<void> actualizarAsignatura(String id, String nuevoNombre) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final index = _asignaturas.indexWhere((a) => a.id == id);
    if (index != -1) {
      _asignaturas[index].nombre = nuevoNombre;
    }
  }

  //elimina una asignatura
  Future<void> eliminarAsignatura(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _asignaturas.removeWhere((a) => a.id == id);
  }
}
