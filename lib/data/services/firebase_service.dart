import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_app/models/asignaturas_model.dart';
import 'package:task_app/models/tarea_model.dart';

class FirebaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // --- Métodos para Asignaturas ---
  Stream<List<Asignatura>> getAsignaturasStream() {
    return _db.collection('asignaturas').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Asignatura.fromJson(doc.data()))
          .toList();
    });
  }

  // --- Métodos para Tareas ---
  Stream<List<Tarea>> getTareasStream() {
    return _db.collection('tareas').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Tarea.fromJson(doc.data())).toList();
    });
  }

  Stream<List<Tarea>> getTareasStreamPorAsignatura(String idAsignatura) {
    return _db
        .collection('tareas')
        .where('idAsignatura', isEqualTo: idAsignatura)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => Tarea.fromJson(doc.data()))
              .toList();
        });
  }

  //Metodos para CRUD de tareas
  Future<void> agregarTarea(Tarea tarea) {
    // 1. Crea una referencia a un nuevo documento para obtener su ID
    final docRef = _db.collection('tareas').doc();
    // 2. Crea una nueva tarea con el ID que acaba de generar
    final tareaConId = tarea.copyWith(id: docRef.id);
    // 3. Guarda la tarea completa en el documento con el método set
    return docRef.set(tareaConId.toJson());
  }

  Future<void> actualizarTarea(Tarea tarea) {
    return _db.collection('tareas').doc(tarea.id).update(tarea.toJson());
  }

  Future<void> eliminarTarea(String id) {
    return _db.collection('tareas').doc(id).delete();
  }

  //Metodos para CRUD de asignaturas
  Future<void> agregarAsignatura(Asignatura asignatura) async {
    // 1. Crea una referencia a un nuevo documento para obtener su ID
    final docRef = _db.collection('asignaturas').doc();
    // 2. Crea una nueva asignatura con el ID que acaba de generar
    final asignaturaConId = asignatura.copyWith(id: docRef.id);
    // 3. Guarda la asignatura completa en el documento con el método set
    return docRef.set(asignaturaConId.toJson());
  }

  Future<void> actualizarAsignatura(Asignatura asignatura) {
    return _db
        .collection('asignaturas')
        .doc(asignatura.id)
        .update(asignatura.toJson());
  }

  Future<void> eliminarAsignatura(String id) {
    return _db.collection('asignaturas').doc(id).delete();
  }
}
