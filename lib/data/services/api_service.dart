import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:task_app/models/asignaturas_model.dart';
import 'package:task_app/models/tarea_model.dart';

class ApiService {
  final String baseUrl = 'http://localhost:3000';

  //Metodos para las asignaturas
  Future<List<Asignatura>> getAsignaturasFromApi() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/asignaturas'));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => Asignatura.fromJson(json)).toList();
      } else {
        throw Exception('Error al cargar las asignaturas');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  //Metodo para la Tareas
  Future<List<Tarea>> getTareasFromApi() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/tareas'));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => Tarea.fromJson(json)).toList();
      } else {
        throw Exception('Error al cargar las tareas');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }
}
