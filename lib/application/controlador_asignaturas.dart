import 'package:get/get.dart';
import 'package:task_app/data/providers/subject_provider.dart';
import 'package:task_app/models/subject_model.dart';

// --- Controlador de Asignaturas ---

//gestionar el estado de las asignaturas

// 1. Obtener la lista de todas las asignaturas desde el `ProveedorAsignaturas`
// 2. Almacenar esta lista en una variable reactiva (`.obs`) para que la UI se actualice automáticamente cuando los datos cambien
// 3. Proporcionar métodos para que la vista pueda añadir, eliminar o actualizar asignaturas

// KAT: Cuando ocupe mostrar la lista de asignaturas simplemente obtendra una instancia de este controlador y accedera a asignaturas.value
class ControladorAsignaturas extends GetxController {

  final ProveedorAsignaturas _proveedorAsignaturas = ProveedorAsignaturas();

  // lista reactiva de asignaturas .obs
  //UI reaccionará a cualquier cambio en esta lista
  var asignaturas = <Asignatura>[].obs;

  //util para mostrar un spinner
  var estaCargando = true.obs;

  // onInit es un método de GetX que se llama automáticamente
  // cuando el controlador es creado por primera vez
  @override
  void onInit() {
    super.onInit();
    cargarAsignaturas();
  }

  //cargar lista de asignaturas desde el proveedor
  void cargarAsignaturas() async {
    try {
      estaCargando(true);
      //LEO: aqui llamar capa de datos
      var resultado = await _proveedorAsignaturas.obtenerTodasLasAsignaturas();
      asignaturas.assignAll(resultado);
    } finally {
      //el indicador de carga se desactiva, incluso si hay un error
      estaCargando(false);
    }
  }

  //añadir nueva asignatura
  void agregarAsignatura(String nombre) async {
    //LEO: Aquí conectar codigo para guardar la nueva asignatura
    await _proveedorAsignaturas.agregarAsignatura(nombre);
    cargarAsignaturas();
  }

  //actualizar una asignatura
  void actualizarAsignatura(String id, String nuevoNombre) async {
    await _proveedorAsignaturas.actualizarAsignatura(id, nuevoNombre);
    cargarAsignaturas();
  }

  //eliminar una asignatura
  void eliminarAsignatura(String id) async {
    await _proveedorAsignaturas.eliminarAsignatura(id);
    cargarAsignaturas();
  }
}
