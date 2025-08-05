import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_app/application/controlador_tareas.dart';
import 'package:task_app/models/task_model.dart';

// ¡Hola, Kat! Este es el formulario para añadir (y luego editar) tareas.
// Te toca a ti dejarlo bonito con un buen diseño.
// Ya tienes los `TextEditingController` para los campos, ¡úsalos a tu gusto!
class PantallaAgregarEditarTarea extends StatelessWidget {
  const PantallaAgregarEditarTarea({super.key});

  @override
  Widget build(BuildContext context) {
    // Buscamos el controlador que ya creamos en la pantalla principal.
    final ControladorTareas controlador = Get.find<ControladorTareas>();

    // Controladores para que los campos de texto funcionen.
    final _tituloController = TextEditingController();
    final _descripcionController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Añadir Tarea')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        // Kat, aquí va tu formulario. Este es solo un esqueleto.
        // Los controladores de texto están listos para que los conectes.
        child: Form(
          child: Column(
            children: [
              TextFormField(
                controller: _tituloController,
                decoration: const InputDecoration(labelText: 'Título'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descripcionController,
                decoration: const InputDecoration(labelText: 'Descripción'),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  // Creamos una tarea nueva con lo que el usuario escribió.
                  final nuevaTarea = Tarea(
                    id: DateTime.now().toString(), // ID de mentirijilla, por ahora.
                    idAsignatura: controlador.idAsignatura, // La asignatura que estamos viendo.
                    titulo: _tituloController.text,
                    descripcion: _descripcionController.text,
                    fechaEntrega: DateTime.now(), // Fecha de mentirijilla también.
                  );

                  // Le pasamos la tarea al controlador para que la guarde.
                  controlador.agregarTarea(nuevaTarea);

                  // ¡Y nos vamos! Volvemos a la pantalla anterior.
                  Get.back();
                },
                child: const Text('Guardar Tarea'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
