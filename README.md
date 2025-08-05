# Plan de Trabajo - Task App

Este archivo documenta el plan de trabajo y las responsabilidades de cada miembro del equipo.

## Roles

*   **Leo:** Gestión de estado con GetX, persistencia de datos (GetStorage/Firebase) y APIs simuladas.
*   **Kat:** Interfaz de usuario (UI), validaciones de formularios y vistas de tareas.
*   **Andy:** Navegación, flujo de la aplicación, manejo de fechas, notificaciones y CRUD de asignaturas y tareas.

---

## Estado Actual del Proyecto (5 de Agosto de 2025)

### ✅ Implementado

*   **Flujo de Tareas Funcional (con datos simulados):**
    *   **Ver la lista de tareas:** La `PantallaHome` muestra las tareas de una asignatura de prueba.
    *   **Añadir nuevas tareas:** La `PantallaAgregarEditarTarea` permite crear tareas y las añade a la lista.
    *   **Ver detalles de una tarea:** La `PantallaDetalleTarea` muestra la información de una tarea seleccionada.
    *   **Marcar tareas como completadas:** Se puede cambiar el estado de una tarea desde la `PantallaHome`.
    *   **Eliminar tareas:** Se puede borrar una tarea desde la `PantallaDetalleTarea`.
*   **Gestión de Estado con GetX:**
    *   Se ha implementado un `ControladorTareas` que maneja toda la lógica de las tareas (añadir, borrar, etc.).
    *   Las vistas reaccionan automáticamente a los cambios en los datos gracias a GetX (`Obx`).

### 🎨 Para Kat (Diseño de UI)

*   **Reemplazar Vistas Temporales:**
    *   `pantalla_home.dart`: Necesita un nuevo diseño para mostrar la lista de tareas y asignaturas.
    *   `pantalla_agregar_editar_tarea.dart`: Hay que crear un formulario bonito y funcional para añadir/editar tareas.
    *   `pantalla_detalle_tarea.dart`: Requiere un diseño para mostrar todos los detalles de una tarea.
*   **Componentes a Crear:**
    *   Un selector de asignaturas en el formulario de tareas.
    *   Un selector de fecha (`DatePicker`) en el formulario.

### 💾 Para Leo (Datos y Backend)

*   **Implementar Persistencia con GetStorage:**
    *   Reemplazar la lógica simulada en `ProveedorTareas` y `ProveedorAsignaturas`.
    *   Los métodos (`agregarTarea`, `eliminarTarea`, etc.) deben ahora guardar y leer los datos de GetStorage en lugar de usar listas en memoria.
*   **IDs Reales:**
    *   La creación de tareas actualmente usa un ID temporal (`DateTime.now()`). Hay que cambiarlo por un sistema de IDs más robusto (ej. un contador o un UUID).

### 🚀 Próximos Pasos (Andy)

*   Implementar el CRUD para las **Asignaturas**.
*   Conectar el `ControladorAsignaturas` a la UI.
*   Añadir manejo de fechas reales y notificaciones (si aplica).
