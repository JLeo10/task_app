import 'package:get/get.dart';
import 'package:task_app/data/providers/subject_provider.dart';
import 'package:task_app/models/subject_model.dart';

// controlador de asignaturas
// gestiona estado de asignaturas
// obtiene lista de asignaturas de proveedorasignaturas
// almacena lista en variable reactiva .obs
// ui se actualiza automaticamente
// provee metodos para crud de asignaturas
// kat: para mostrar asignaturas, usa este controlador
// accede a asignaturas.value
class ControladorAsignaturas extends GetxController {
  // Instancia del proveedor de datos de asignaturas.
  final ProveedorAsignaturas _proveedorAsignaturas = ProveedorAsignaturas();

  // --- Variables de Estado ---

  // Lista reactiva de asignaturas. `.obs` la convierte en un "observable".
  // La UI reaccionará a cualquier cambio en esta lista.
  var asignaturas = <Asignatura>[].obs;

  // Variable para controlar el estado de carga. Útil para mostrar un spinner.
  var estaCargando = true.obs;

  // --- Ciclo de Vida del Controlador ---

  // `onInit` es un método de GetX que se llama automáticamente
  // cuando el controlador es creado por primera vez.
  @override
  void onInit() {
    super.onInit();
    // Cargamos las asignaturas tan pronto como el controlador está listo.
    cargarAsignaturas();
  }

  // --- Métodos (Lógica de Negocio) ---

  // Carga la lista de asignaturas desde el proveedor.
  void cargarAsignaturas() async {
    try {
      estaCargando(true);
      // LEO: Aquí se llama a tu capa de datos.
      var resultado = await _proveedorAsignaturas.obtenerTodasLasAsignaturas();
      asignaturas.assignAll(resultado);
    } finally {
      // Nos aseguramos de que el indicador de carga se desactive, incluso si hay un error.
      estaCargando(false);
    }
  }

  // Lógica para añadir una nueva asignatura.
  void agregarAsignatura(String nombre) async {
    // LEO: Aquí se conectará tu lógica para guardar la nueva asignatura.
    await _proveedorAsignaturas.agregarAsignatura(nombre);
    // Volvemos a cargar la lista para reflejar el cambio.
    cargarAsignaturas();
  }

  // Lógica para actualizar una asignatura.
  void actualizarAsignatura(String id, String nuevoNombre) async {
    await _proveedorAsignaturas.actualizarAsignatura(id, nuevoNombre);
    cargarAsignaturas();
  }

  // elimina asignatura
  void eliminarAsignatura(String id) async {
    await _proveedorAsignaturas.eliminarAsignatura(id);
    cargarAsignaturas();
  }
}
