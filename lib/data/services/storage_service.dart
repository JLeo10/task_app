// import 'dart:convert';
// import 'package:get_storage/get_storage.dart';
// import 'package:task_app/models/asignaturas_model.dart'; // Asegúrate de que este sea el path correcto
// import 'package:task_app/models/tarea_model.dart'; // Asegúrate de que este sea el path correcto

// class StorageService {
//   final GetStorage _box = GetStorage();
//   final String _tasksKey = 'tareas';
//   final String _subjectsKey = 'asignaturas';

//   // --- Métodos para Tareas ---
//   void saveTasks(List<Tarea> tareas) {
//     final tareasJson = tareas.map((tarea) => tarea.toJson()).toList();
//     _box.write(_tasksKey, jsonEncode(tareasJson));
//   }

//   List<Tarea> getTasks() {
//     final tareasJsonString = _box.read(_tasksKey) as String?;
//     if (tareasJsonString == null) {
//       return [];
//     }
//     final tareasJson = jsonDecode(tareasJsonString) as List<dynamic>;
//     return tareasJson.map((json) => Tarea.fromJson(json)).toList();
//   }

//   // --- Métodos para Asignaturas ---
//   void saveAsignaturas(List<Asignatura> asignaturas) {
//     final asignaturasJson = asignaturas
//         .map((asignatura) => asignatura.toJson())
//         .toList();
//     _box.write(_subjectsKey, jsonEncode(asignaturasJson));
//   }

//   List<Asignatura> getAsignaturas() {
//     final asignaturasJsonString = _box.read(_subjectsKey) as String?;
//     if (asignaturasJsonString == null) {
//       return [];
//     }
//     final asignaturasJson = jsonDecode(asignaturasJsonString) as List<dynamic>;
//     return asignaturasJson.map((json) => Asignatura.fromJson(json)).toList();
//   }
// }
