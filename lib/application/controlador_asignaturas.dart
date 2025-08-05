'''import 'package:get/get.dart';
import 'package:task_app/data/providers/subject_provider.dart';
import 'package:task_app/models/subject_model.dart';

// --- Controlador de Asignaturas ---
//
// ¿Para qué sirve?
// Este controlador se encarga de gestionar el estado de las asignaturas.
// Su responsabilidad es:
// 1. Obtener la lista de todas las asignaturas desde el `ProveedorAsignaturas`.
// 2. Almacenar esta lista en una variable reactiva (`.obs`) para que la UI se
//    actualice automáticamente cuando los datos cambien.
// 3. Proporcionar métodos para que la vista pueda añadir, eliminar o actualizar asignaturas.
//
// KAT: Cuando necesites mostrar la lista de asignaturas (por ejemplo, en un Dropdown),
//      simplemente obtendrás una instancia de este controlador y accederás a `asignaturas.value`.
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
}
''