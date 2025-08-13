// Modelo para las tareas de la aplicación
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

  //metodo convertir un objeto Tarea a un mapa JSON
  //LEO lo ocuapara para guardar los datos en GetStorage
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'idAsignatura': idAsignatura,
      'titulo': titulo,
      'descripcion': descripcion,
      'fechaEntrega': fechaEntrega
          .toIso8601String(), //guardamos la fecha en formato estándar
      'estaCompletada': estaCompletada,
    };
  }

  factory Tarea.fromJson(String id, Map<String, dynamic> json) {
    return Tarea(
      id: id, // Ahora usamos el ID que se pasa como argumento
      idAsignatura: json['idAsignatura'],
      titulo: json['titulo'],
      descripcion: json['descripcion'],
      fechaEntrega: DateTime.parse(
        json['fechaEntrega'],
      ), //convierte string a datetime
      estaCompletada: json['estaCompletada'],
    );
  }

  //metodo copyWith para facilitar la creación de nuevas instancias con propiedades modificadas
  Tarea copyWith({
    String? id,
    String? idAsignatura,
    String? titulo,
    String? descripcion,
    DateTime? fechaEntrega,
    bool? estaCompletada,
  }) {
    return Tarea(
      id: id ?? this.id,
      idAsignatura: idAsignatura ?? this.idAsignatura,
      titulo: titulo ?? this.titulo,
      descripcion: descripcion ?? this.descripcion,
      fechaEntrega: fechaEntrega ?? this.fechaEntrega,
      estaCompletada: estaCompletada ?? this.estaCompletada,
    );
  }
}
