import 'package:get/get.dart';
import 'package:task_app/pantalla_agregar_editar_tarea.dart';

import 'package:task_app/pantalla_home.dart';
import 'package:task_app/pantalla_login.dart';
import 'package:task_app/pantalla_tareas_por_asignatura.dart';
import 'package:task_app/modules/auth/views/register_page.dart';
import 'package:task_app/pantalla_calendario.dart';
import 'package:task_app/pantalla_vista_semanal.dart';

// define rutas de la aplicacion para navegacion con getx
class AppRutas {
  static final rutas = [
    GetPage(name: '/login', page: () => const PantallaLogin()),
    GetPage(name: '/register', page: () => const RegisterPage()),
    GetPage(name: '/home', page: () => const PantallaHome()),
    GetPage(
      name: '/tareas_por_asignatura',
      page: () => const PantallaTareasPorAsignatura(),
    ),
    // TODO: Añadir las siguientes rutas cuando las pantallas estén creadas
    
    GetPage(
      name: '/agregar_editar_tarea',
      page: () => const PantallaAgregarEditarTarea(),
    ),
    GetPage(
      name: '/calendario/:asignaturaId',
      page: () => PantallaCalendario(asignaturaId: Get.parameters['asignaturaId']!),
    ),
    GetPage(
      name: '/vista_semanal/:asignaturaId',
      page: () => PantallaVistaSemanal(asignaturaId: Get.parameters['asignaturaId']!),
    ),
  ];
}
