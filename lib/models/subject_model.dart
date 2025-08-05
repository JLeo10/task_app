// Modelo para las asignaturas de la aplicación.
class Asignatura {
  String id;
  String nombre;

  Asignatura({
    required this.id,
    required this.nombre,
  });

  // Método para convertir un objeto Asignatura a un mapa JSON.
  // Leo lo necesitará para guardar los datos en GetStorage.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
    };
  }

  // Método para crear un objeto Asignatura desde un mapa JSON.
  // Leo lo usará para leer los datos guardados.
  factory Asignatura.fromJson(Map<String, dynamic> json) {
    return Asignatura(
      id: json['id'],
      nombre: json['nombre'],
    );
  }
}
