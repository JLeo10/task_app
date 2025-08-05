import 'package:get/get.dart';
import 'package:task_app/data/providers/task_provider.dart';
import 'package:task_app/models/task_model.dart';

// --- Controlador de Tareas ---

//manejar las tareas de UNA asignatura
// Guarda lista obs que se actualiza sola
//funciones añadir, editar, borrar, completar tareas

class ControladorTareas extends GetxController {
  //conecta con la BD (o lo que sea que ponga Leo)
  final ProveedorTareas _proveedorTareas = ProveedorTareas();

  // --- Variables de Estado ---

  final String idAsignatura;

  var tareas = <Tarea>[].obs;
  var estaCargando = true.obs; //para mostrar una ruedita de carga

  //Le pasamos el ID de la asignatura de la que queremos gestionar las tareas
  ControladorTareas(this.idAsignatura);

  @override
  void onInit() {
    super.onInit();
    cargarTareas();
  }

  // --- MEtodos ---

  //capta las tareas del proveedor de datos
  void cargarTareas() async {
    try {
      estaCargando(true);
      //LEO: tu código para captar tareas
      var resultado = await _proveedorTareas.obtenerTareasPorAsignatura(
        idAsignatura,
      );
      tareas.assignAll(resultado);
    } finally {
      estaCargando(false);
    }
  }

  //añade una tarea nueva
  void agregarTarea(Tarea nuevaTarea) async {
    // Aseguramos que la tarea se asocie a la asignatura correcta
    final tareaConAsignatura = nuevaTarea.copyWith(idAsignatura: idAsignatura);
    await _proveedorTareas.agregarTarea(tareaConAsignatura);
    cargarTareas(); //actualizamos lista para que se vea la nueva tarea
  }

  //actualiza una tarea existente
  void actualizarTarea(Tarea tareaActualizada) async {
    await _proveedorTareas.actualizarTarea(tareaActualizada);
    cargarTareas();
  }

  //marcar una tarea como hecha (o no)
  void marcarComoCompletada(String idTarea) async {
    //LEO: actualizaresto en la base de datos
    await _proveedorTareas.marcarComoCompletada(idTarea);
    cargarTareas(); //actualizamos para que el checkbox cambie
  }

  //borra una tarea
  void eliminarTarea(String idTarea) async {
    await _proveedorTareas.eliminarTarea(idTarea);
  }
}
