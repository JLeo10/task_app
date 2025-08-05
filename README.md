plan de trabajo - task app

este archivo documenta el plan de trabajo y las responsabilidades de cada miembro del equipo

roles

* leo: gestion de estado con getx, persistencia de datos (getstorage/firebase) y apis simuladas
* kat: interfaz de usuario (ui), validaciones de formularios y vistas de tareas
* andy: navegacion, flujo de la aplicacion, manejo de fechas, notificaciones y crud de asignaturas y tareas

estado actual del proyecto (5 de agosto de 2025)

implementado

* crud de asignaturas funcional (datos simulados)
  * ver lista de asignaturas: pantallahome muestra todas las asignaturas
  * añadir nuevas asignaturas: dialogo permite crear asignaturas
  * editar asignaturas: permite cambiar nombre de asignaturas existentes
  * eliminar asignaturas: permite borrar asignaturas de la lista
* crud de tareas funcional (datos simulados)
  * ver lista de tareas: pantallatareaporasignatura muestra tareas de asignatura especifica
  * añadir nuevas tareas: permite añadir tareas asociadas a una asignatura
  * editar tareas: permite editar tareas existentes
  * marcar tareas como completadas: permite cambiar estado de una tarea
  * eliminar tareas: permite borrar una tarea
* navegacion
  * de pantallahome a pantallatareaporasignatura (pasando la asignatura)
  * de pantallatareaporasignatura a pantallaagregareditartarea (para añadir tareas a la asignatura actual)
  * de pantalladetalltarea a pantallaagregareditartarea (para editar una tarea existente)
* manejo de fechas
  * implementado datepicker en pantallaagregareditartarea para seleccionar fecha de entrega
  * fecha de entrega se muestra formateada en pantalladetalltarea
* gestion de estado con getx
  * controladorasignaturas y controladortareas manejan la logica de negocio

para kat (diseño de ui)

* reemplazar vistas temporales
  * pantallahome: necesita nuevo diseño para mostrar lista de asignaturas
  * pantallaagregareditartarea: crear formulario funcional para añadir/editar tareas
  * pantalladetalltarea: requiere diseño para mostrar detalles de una tarea
  * pantallatareaporasignatura: necesita diseño para mostrar tareas de una asignatura
  * diseñar dialogo de añadir/editar asignatura en pantallahome
* componentes a crear
  * selector de asignaturas en formulario de tareas
  * selector de fecha (datepicker) en formulario

para leo (datos y backend)

* implementar persistencia con getstorage
  * reemplazar logica simulada en proveedortareas y proveedorasignaturas
  * metodos (agregartarea, eliminarasignatura, etc) deben guardar y leer datos de getstorage
* ids reales
  * creacion de tareas y asignaturas usa id temporal (datetime.now)
  * cambiar por sistema de ids mas robusto (ej contador o uuid)

proximos pasos (andy)

* revision general del codigo para optimizacion y adherencia a mejores practicas
* refactorizacion de comentarios para seguir estilo consistente y conciso