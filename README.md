# Tareas Universitarias: Tu Gestor de Tareas Académicas

## Descripción del Proyecto
"Tareas Universitarias" es una aplicación móvil diseñada para ayudar a estudiantes a organizar y gestionar sus responsabilidades académicas de manera eficiente. Permite a los usuarios registrar y hacer seguimiento de sus tareas, asignarlas a asignaturas específicas y monitorear su progreso. La aplicación busca simplificar la vida académica, asegurando que ninguna fecha de entrega importante sea olvidada.

## Funcionalidades Clave

*   **Registro e Inicio de Sesión Seguro:** Autenticación de usuarios a través de Firebase para garantizar la seguridad y persistencia de los datos.
*   **Gestión Completa de Asignaturas (CRUD):**
    *   **Crear:** Añade nuevas asignaturas a tu lista.
    *   **Leer:** Visualiza todas tus asignaturas registradas.
    *   **Actualizar:** Modifica los detalles de tus asignaturas existentes.
    *   **Eliminar:** Remueve asignaturas que ya no necesites.
*   **Gestión Detallada de Tareas por Asignatura (CRUD):**
    *   **Crear:** Registra nuevas tareas con título, descripción, fecha de entrega y estado.
    *   **Leer:** Consulta tus tareas organizadas por asignatura.
    *   **Actualizar:** Edita cualquier detalle de tus tareas.
    *   **Eliminar:** Borra tareas completadas o canceladas.
*   **Visualización Flexible de Tareas:**
    *   **Por Asignatura:** Organiza y visualiza tus tareas agrupadas por cada materia.
    *   **Vista Semanal:** Consulta tus tareas organizadas por día de la semana.
    *   **Vista de Calendario:** Visualiza tus tareas en un calendario interactivo, con la posibilidad de ver tareas por día.
*   **Control de Progreso:** Marca tareas como completadas para llevar un registro claro de tus logros.
*   ~~Notificaciones de Recordatorio (Opcional):~~ *Funcionalidad eliminada para simplificar el proyecto y evitar problemas de configuración.*

## Componentes Técnicos Destacados

*   **Manejo de Fechas:** Implementación robusta con `DateTime` y `DatePicker` para una gestión intuitiva de fechas de entrega.
*   **Navegación:** Utilización de `go_router` para una navegación fluida y estructurada entre las diferentes secciones de la aplicación.
*   **Gestión de Estado:** Empleo de `GetX` para un manejo de estado reactivo y eficiente, garantizando una interfaz de usuario dinámica.
*   **Persistencia de Datos:**
    *   **Firebase Firestore:** Almacenamiento remoto y en tiempo real de todas las asignaturas y tareas, permitiendo la sincronización entre dispositivos.
    *   **GetStorage (para futuras implementaciones):** Preparado para una posible persistencia local inicial para otros módulos o configuraciones de usuario.
*   **Consumo de APIs Simuladas (para desarrollo):** Posibilidad de integrar `JSON Server` o `MockAPI` para simular el consumo de datos durante el desarrollo.
*   **Validaciones de Formularios:** Implementación de validaciones para asegurar la integridad de los datos ingresados por el usuario.
*   **Controladores de Texto:** Uso adecuado de `TextEditingController` para una interacción precisa con los campos de entrada de texto.

## Nota para la Entrega

*   **Repositorio del Proyecto:** Asegúrate de que el repositorio refleje las contribuciones de todos los miembros del equipo. La participación equitativa es fundamental.
*   **README Completo:** Este archivo debe contener la descripción detallada de la aplicación y la lista de los integrantes del equipo.

## Integrantes del Equipo
*   [Nombre del Integrante 1]
*   [Nombre del Integrante 2]
*   [Nombre del Integrante 3]
*   [Nombre del Integrante 4]
