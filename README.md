# Plan de Trabajo - Task App

Este archivo documenta el plan de trabajo y las responsabilidades de cada miembro del equipo.

## Roles

*   **Leo:** Gestión de estado con GetX, persistencia de datos (GetStorage/Firebase) y APIs simuladas.
*   **Kat:** Interfaz de usuario (UI), validaciones de formularios y vistas de tareas.
*   **Andy:** Navegación, flujo de la aplicación, manejo de fechas, notificaciones y CRUD de asignaturas y tareas.

---

## Estado Actual del Proyecto (5 de Agosto de 2025)

### ✅ Implementado

*   **CRUD de Asignaturas Funcional (con datos simulados):**
    *   **Ver la lista de asignaturas:** La `PantallaHome` ahora muestra todas las asignaturas.
    *   **Añadir nuevas asignaturas:** Un diálogo permite crear asignaturas.
    *   **Editar asignaturas:** Se puede cambiar el nombre de las asignaturas existentes.
    *   **Eliminar asignaturas:** Se pueden borrar asignaturas de la lista.
*   **CRUD de Tareas Funcional (con datos simulados):**
    *   **Ver la lista de tareas:** `PantallaTareasPorAsignatura` muestra las tareas de una asignatura específica.
    *   **Añadir nuevas tareas:** Se pueden añadir tareas asociadas a una asignatura.
    *   **Editar tareas:** Se pueden editar tareas existentes.
    *   **Marcar tareas como completadas:** Se puede cambiar el estado de una tarea.
    *   **Eliminar tareas:** Se puede borrar una tarea.
*   **Navegación:**
    *   De `PantallaHome` a `PantallaTareasPorAsignatura` (pasando la asignatura).
    *   De `PantallaTareasPorAsignatura` a `PantallaAgregarEditarTarea` (para añadir tareas a la asignatura actual).
    *   De `PantallaDetalleTarea` a `PantallaAgregarEditarTarea` (para editar una tarea existente).
*   **Manejo de Fechas:**
    *   Implementado `DatePicker` en `PantallaAgregarEditarTarea` para seleccionar la fecha de entrega.
    *   La fecha de entrega se muestra formateada en `PantallaDetalleTarea`.
*   **Gestión de Estado con GetX:**
    *   `ControladorAsignaturas` y `ControladorTareas` manejan la lógica de negocio.

### 🎨 Para Kat (Diseño de UI)

*   **Reemplazar Vistas Temporales:**
    *   `pantalla_home.dart`: Necesita un nuevo diseño para mostrar la lista de asignaturas.
    *   `pantalla_agregar_editar_tarea.dart`: Hay que crear un formulario bonito y funcional para añadir/editar tareas.
    *   `pantalla_detalle_tarea.dart`: Requiere un diseño para mostrar todos los detalles de una tarea.
    *   `pantalla_tareas_por_asignatura.dart`: Necesita un diseño para mostrar las tareas de una asignatura.
    *   **Nuevo:** Diseñar el diálogo de `Añadir/Editar Asignatura` que se muestra en la `PantallaHome`.
*   **Componentes a Crear:**
    *   Un selector de asignaturas en el formulario de tareas.
    *   Un selector de fecha (`DatePicker`) en el formulario.

### 💾 Para Leo (Datos y Backend)

*   **Implementar Persistencia con GetStorage:**
    *   Reemplazar la lógica simulada en `ProveedorTareas` y `ProveedorAsignaturas`.
    *   Los métodos (`agregarTarea`, `eliminarAsignatura`, etc.) deben ahora guardar y leer los datos de GetStorage en lugar de usar listas en memoria.
*   **IDs Reales:**
    *   La creación de tareas y asignaturas actualmente usa un ID temporal (`DateTime.now()`). Hay que cambiarlo por un sistema de IDs más robusto (ej. un contador o un UUID).

### 🚀 Próximos Pasos (Andy)

*   Revisión general del código para optimización y adherencia a las mejores prácticas.
*   Refactorización de comentarios para seguir un estilo consistente y conciso.