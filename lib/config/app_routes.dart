import 'package:get/get.dart';
import 'package:task_app/pantalla_agregar_editar_tarea.dart';
import 'package:task_app/pantalla_detalle_tarea.dart';
import 'package:task_app/pantalla_home.dart';
import 'package:task_app/pantalla_login.dart';
import 'package:task_app/pantalla_tareas_por_asignatura.dart';

// define rutas de la aplicacion para navegacion con getx
class AppRutas {
  static final rutas = [
    GetPage(name: '/login', page: () => const PantallaLogin()),
    GetPage(name: '/home', page: () => const PantallaHome()),
    GetPage(name: '/detalle_tarea', page: () => const PantallaDetalleTarea()),
    GetPage(
      name: '/agregar_editar_tarea',
      page: () => const PantallaAgregarEditarTarea(),
    ),
    GetPage(
      name: '/tareas_por_asignatura',
      page: () => PantallaTareasPorAsignatura(asignatura: Get.arguments),
    ),
  ];
}
