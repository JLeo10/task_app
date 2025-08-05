//modelo para las asignaturas de la aplicación
class Asignatura {
  String id;
  String nombre;

  Asignatura({required this.id, required this.nombre});

  //metodo convertir un objeto Tarea a un mapa JSON
  //LEO lo ocuapara para guardar los datos en GetStorage
  Map<String, dynamic> toJson() {
    return {'id': id, 'nombre': nombre};
  }

  //crea asignatura desde json para leo
  factory Asignatura.fromJson(Map<String, dynamic> json) {
    return Asignatura(id: json['id'], nombre: json['nombre']);
  }
}
