import 'package:get/get.dart';
import 'package:task_app/data/providers/task_provider.dart';
import 'package:task_app/models/task_model.dart';

// --- Controlador de Tareas ---
//
// ¿Qué hace este bicho?
// Básicamente, se encarga de manejar las tareas de UNA asignatura.
// Sus superpoderes son:
// 1. Pillar las tareas de la asignatura que le digas.
// 2. Guardarlas en una lista mágica (`.obs`) que se actualiza sola.
// 3. Darte funciones para añadir, editar, borrar y completar tareas.
//
// Oye, KAT: Cuando quieras mostrar las tareas de una asignatura, usa esto.
// Le das el ID de la asignatura y ¡listo!, él hace el trabajo sucio.
class ControladorTareas extends GetxController {
  // Este es nuestro colega que habla con la base de datos (o lo que sea que ponga Leo).
  final ProveedorTareas _proveedorTareas = ProveedorTareas();

  // --- Variables de Estado (la chicha del controlador) ---

  // El DNI de la asignatura con la que estamos trabajando.
  final String idAsignatura;

  // La lista de tareas que se actualiza sola. ¡Magia!
  var tareas = <Tarea>[].obs;
  var estaCargando = true.obs; // Para mostrar una ruedita de carga.

  // El constructor. Le pasamos el ID de la asignatura para que sepa con qué currar.
  ControladorTareas(this.idAsignatura);

  // --- Ciclo de Vida (lo que hace al nacer) ---

  @override
  void onInit() {
    super.onInit();
    // Nada más nacer, se pone a buscar las tareas de su asignatura.
    cargarTareas();
  }

  // --- Métodos (la lógica del negocio) ---

  // Pilla las tareas del proveedor de datos.
  void cargarTareas() async {
    try {
      estaCargando(true);
      // ¡Eh, LEO! Aquí llamamos a tu código para pillar las tareas.
      var resultado = await _proveedorTareas.obtenerTareasPorAsignatura(idAsignatura);
      tareas.assignAll(resultado);
    } finally {
      estaCargando(false);
    }
  }

  // Añade una tarea nueva.
  void agregarTarea(Tarea nuevaTarea) async {
    // ¡LEO! Aquí es donde tu magia de guardar cosas entra en acción.
    await _proveedorTareas.agregarTarea(nuevaTarea);
    cargarTareas(); // Actualizamos la lista para que se vea la nueva tarea.
  }

  // Marca una tarea como hecha (o no).
  void marcarComoCompletada(String idTarea) async {
    // ¡LEO! Necesitamos que actualices esto en la base de datos.
    await _proveedorTareas.marcarComoCompletada(idTarea);
    cargarTareas(); // Actualizamos para que el checkbox cambie.
  }

  // Borra una tarea. ¡Puf! Desapareció.
  void eliminarTarea(String idTarea) async {
    // ¡LEO! A la basura con esta tarea.
    await _proveedorTareas.eliminarTarea(idTarea);
    cargarTareas(); // Actualizamos para que no se vea más.
  }
}
