import 'package:get/get.dart';
import 'package:task_app/pantalla_agregar_editar_tarea.dart';
import 'package:task_app/pantalla_detalle_tarea.dart';
import 'package:task_app/pantalla_home.dart';
import 'package:task_app/pantalla_login.dart';

// Define todas las rutas de la aplicación para la navegación con GetX.
class AppRutas {
  static final rutas = [
    GetPage(name: '/login', page: () => const PantallaLogin()),
    GetPage(name: '/home', page: () => const PantallaHome()),
    GetPage(name: '/detalle_tarea', page: () => const PantallaDetalleTarea()),
    GetPage(name: '/agregar_editar_tarea', page: () => const PantallaAgregarEditarTarea()),
  ];
}
