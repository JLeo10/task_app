import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // necesario para formatear la fecha
import 'package:task_app/application/controlador_tareas.dart';
import 'package:task_app/models/task_model.dart';

//KAT: formulario para añadir y editar tareas

class PantallaAgregarEditarTarea extends StatefulWidget {
  const PantallaAgregarEditarTarea({super.key});

  @override
  State<PantallaAgregarEditarTarea> createState() => _PantallaAgregarEditarTareaState();
}

class _PantallaAgregarEditarTareaState extends State<PantallaAgregarEditarTarea> {
  final _tituloController = TextEditingController();
  final _descripcionController = TextEditingController();
  final _fechaEntregaController = TextEditingController();
  DateTime? _fechaSeleccionada;

  String? idAsignatura;
  Tarea? tareaParaEditar;
  bool esEdicion = false;

  @override
  void initState() {
    super.initState();
    idAsignatura = Get.arguments is String ? Get.arguments : null;
    tareaParaEditar = Get.arguments is Tarea ? Get.arguments : null;
    esEdicion = tareaParaEditar != null;

    if (esEdicion) {
      _tituloController.text = tareaParaEditar!.titulo;
      _descripcionController.text = tareaParaEditar!.descripcion;
      _fechaSeleccionada = tareaParaEditar!.fechaEntrega;
      _fechaEntregaController.text = DateFormat('dd/MM/yyyy').format(_fechaSeleccionada!); //formatear para mostrar
    }
  }

  @override
  Widget build(BuildContext context) {
    final ControladorTareas controlador = Get.put(ControladorTareas(idAsignatura ?? tareaParaEditar?.idAsignatura ?? '1'));

    return Scaffold(
      appBar: AppBar(title: Text(esEdicion ? 'Editar Tarea' : 'Añadir Tarea')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
              const SizedBox(height: 16),
              TextFormField(
                controller: _fechaEntregaController,
                decoration: const InputDecoration(
                  labelText: 'Fecha de Entrega',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                readOnly: true, //para que no se pueda escribir directamente
                onTap: () async {
                  //abre selector de fecha
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: _fechaSeleccionada ?? DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (picked != null && picked != _fechaSeleccionada) {
                    setState(() {
                      _fechaSeleccionada = picked;
                      _fechaEntregaController.text = DateFormat('dd/MM/yyyy').format(picked);
                    });
                  }
                },
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  if (_tituloController.text.isEmpty || _fechaSeleccionada == null) {
                    Get.snackbar('Error', 'Agregue el título y seleccione una fecha de entrega.');
                    return;
                  }

                  if (esEdicion) {
                    final tareaActualizada = tareaParaEditar!.copyWith(
                      titulo: _tituloController.text,
                      descripcion: _descripcionController.text,
                      fechaEntrega: _fechaSeleccionada!,
                    );
                    controlador.actualizarTarea(tareaActualizada);
                  } else {
                    final nuevaTarea = Tarea(
                      id: DateTime.now().toString(),
                      idAsignatura: idAsignatura!,
                      titulo: _tituloController.text,
                      descripcion: _descripcionController.text,
                      fechaEntrega: _fechaSeleccionada!,
                    );
                    controlador.agregarTarea(nuevaTarea);
                  }
                  Get.back();
                },
                child: Text(esEdicion ? 'Guardar Cambios' : 'Guardar Tarea'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
