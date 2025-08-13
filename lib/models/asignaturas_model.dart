//modelo para las asignaturas de la aplicación
class Asignatura {
  String id;
  String nombre;

  Asignatura({required this.id, required this.nombre});

  Asignatura copyWith({String? id, String? nombre}) {
    return Asignatura(id: id ?? this.id, nombre: nombre ?? this.nombre);
  }

  //metodo convertir un objeto Tarea a un mapa JSON
  Map<String, dynamic> toJson() {
    return {'id': id, 'nombre': nombre};
  }

  factory Asignatura.fromJson(String id, Map<String, dynamic> json) {
    return Asignatura(
      id: id, // Usamos el ID que se pasa como argumento
      nombre: json['nombre'],
    );
  }
}
