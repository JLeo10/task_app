import 'package:task_app/models/subject_model.dart';

// Modelo para las tareas de la aplicación.
class Tarea {
  String id;
  String idAsignatura;
  String titulo;
  String descripcion;
  DateTime fechaEntrega;
  bool estaCompletada;

  Tarea({
    required this.id,
    required this.idAsignatura,
    required this.titulo,
    required this.descripcion,
    required this.fechaEntrega,
    this.estaCompletada = false,
  });

  // Método para convertir un objeto Tarea a un mapa JSON.
  // Leo lo necesitará para guardar los datos en GetStorage.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'idAsignatura': idAsignatura,
      'titulo': titulo,
      'descripcion': descripcion,
      'fechaEntrega': fechaEntrega.toIso8601String(), // Guardamos la fecha en formato estándar
      'estaCompletada': estaCompletada,
    };
  }

  // Método para crear un objeto Tarea desde un mapa JSON.
  // Leo lo usará para leer los datos guardados.
  factory Tarea.fromJson(Map<String, dynamic> json) {
    return Tarea(
      id: json['id'],
      idAsignatura: json['idAsignatura'],
      titulo: json['titulo'],
      descripcion: json['descripcion'],
      fechaEntrega: DateTime.parse(json['fechaEntrega']), // Convertimos el string a DateTime
      estaCompletada: json['estaCompletada'],
    );
  }
}
