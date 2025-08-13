// lib/data/services/firebase_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_app/models/asignaturas_model.dart';
import 'package:task_app/models/tarea_model.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get _currentUserId => _auth.currentUser?.uid;

  // --- MÉTODOS DE ASIGNATURAS ---
  Stream<List<Asignatura>> getAsignaturasStream() {
    if (_currentUserId == null) {
      throw Exception('Usuario no autenticado.');
    }
    return _firestore
        .collection('users')
        .doc(_currentUserId)
        .collection('asignaturas')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => Asignatura.fromJson(doc.id, doc.data()))
              .toList(),
        );
  }

  Future<void> agregarAsignatura(Asignatura asignatura) async {
    if (_currentUserId == null) {
      throw Exception('Usuario no autenticado.');
    }
    await _firestore
        .collection('users')
        .doc(_currentUserId)
        .collection('asignaturas')
        .add(asignatura.toJson());
  }

  Future<void> actualizarAsignatura(Asignatura asignatura) async {
    if (_currentUserId == null) {
      throw Exception('Usuario no autenticado.');
    }
    await _firestore
        .collection('users')
        .doc(_currentUserId)
        .collection('asignaturas')
        .doc(asignatura.id)
        .update(asignatura.toJson());
  }

  Future<void> eliminarAsignatura(String id) async {
    if (_currentUserId == null) {
      throw Exception('Usuario no autenticado.');
    }
    await _firestore
        .collection('users')
        .doc(_currentUserId)
        .collection('asignaturas')
        .doc(id)
        .delete();
  }

  Future<Asignatura?> getAsignaturaById(String asignaturaId) async {
    if (_currentUserId == null) {
      throw Exception('Usuario no autenticado.');
    }
    final doc = await _firestore
        .collection('users')
        .doc(_currentUserId)
        .collection('asignaturas')
        .doc(asignaturaId)
        .get();
    if (doc.exists) {
      return Asignatura.fromJson(doc.id, doc.data()!);
    } else {
      return null;
    }
  }

  // --- MÉTODOS DE TAREAS ---
  Stream<List<Tarea>> getTareasStreamPorAsignatura(String idAsignatura) {
    if (_currentUserId == null) {
      throw Exception('Usuario no autenticado.');
    }
    return _firestore
        .collection('users')
        .doc(_currentUserId)
        .collection('asignaturas')
        .doc(idAsignatura)
        .collection('tareas')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => Tarea.fromJson(doc.id, doc.data()))
              .toList(),
        );
  }

  Future<void> agregarTarea(Tarea nuevaTarea) async {
    if (_currentUserId == null) {
      throw Exception('Usuario no autenticado.');
    }
    await _firestore
        .collection('users')
        .doc(_currentUserId)
        .collection('asignaturas')
        .doc(nuevaTarea.idAsignatura)
        .collection('tareas')
        .add(nuevaTarea.toJson());
  }

  Future<void> actualizarTarea(Tarea tareaActualizada) async {
    if (_currentUserId == null) {
      throw Exception('Usuario no autenticado.');
    }
    await _firestore
        .collection('users')
        .doc(_currentUserId)
        .collection('asignaturas')
        .doc(tareaActualizada.idAsignatura)
        .collection('tareas')
        .doc(tareaActualizada.id)
        .update(tareaActualizada.toJson());
  }

  Future<void> eliminarTarea(String idAsignatura, String idTarea) async {
    if (_currentUserId == null) {
      throw Exception('Usuario no autenticado.');
    }
    await _firestore
        .collection('users')
        .doc(_currentUserId)
        .collection('asignaturas')
        .doc(idAsignatura)
        .collection('tareas')
        .doc(idTarea)
        .delete();
  }
}
