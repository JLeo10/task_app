import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_app/application/controlador_asignaturas.dart';
import 'package:task_app/application/controlador_tareas.dart';
import 'package:task_app/models/asignaturas_model.dart';
import 'package:task_app/models/tarea_model.dart';

class PantallaAgregarEditarTarea extends StatefulWidget {
  const PantallaAgregarEditarTarea({super.key});

  @override
  State<PantallaAgregarEditarTarea> createState() =>
      _PantallaAgregarEditarTareaState();
}

class _PantallaAgregarEditarTareaState
    extends State<PantallaAgregarEditarTarea> {
  final _tituloController = TextEditingController();
  final _descripcionController = TextEditingController();
  final _fechaEntregaController = TextEditingController();
  DateTime? _fechaSeleccionada;

  Asignatura? _asignatura;
  Tarea? _tareaParaEditar;
  bool esEdicion = false;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments;

    if (args is Asignatura) {
      _asignatura = args;
      esEdicion = false;
    } else if (args is Tarea) {
      _tareaParaEditar = args;
      esEdicion = true;
      _asignatura = Get.find<AsignaturaController>().asignaturas
          .firstWhereOrNull((a) => a.id == _tareaParaEditar?.idAsignatura);

      _tituloController.text = _tareaParaEditar?.titulo ?? '';
      _descripcionController.text = _tareaParaEditar?.descripcion ?? '';
      _fechaSeleccionada = _tareaParaEditar?.fechaEntrega;
      if (_fechaSeleccionada != null) {
        _fechaEntregaController.text = DateFormat(
          'dd/MM/yyyy',
        ).format(_fechaSeleccionada!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final TareaController controlador = Get.find<TareaController>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          esEdicion
              ? 'Editar Tarea'
              : 'Añadir Tarea para ${_asignatura?.nombre ?? 'Desconocida'}',
        ),
      ),
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
                readOnly: true,
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: _fechaSeleccionada ?? DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (picked != null && picked != _fechaSeleccionada) {
                    setState(() {
                      _fechaSeleccionada = picked;
                      _fechaEntregaController.text = DateFormat(
                        'dd/MM/yyyy',
                      ).format(picked);
                    });
                  }
                },
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  if (_tituloController.text.isEmpty) {
                    Get.snackbar(
                      'Error',
                      'El título de la tarea no puede estar vacío.',
                    );
                    return;
                  }
                  if (_fechaSeleccionada == null) {
                    Get.snackbar(
                      'Error',
                      'Debe seleccionar una fecha de entrega.',
                    );
                    return;
                  }
                  if (_asignatura == null) {
                    Get.snackbar(
                      'Error',
                      'La asignatura no se pudo cargar. Intente de nuevo.',
                    );
                    return;
                  }

                  if (esEdicion) {
                    final tareaActualizada = _tareaParaEditar!.copyWith(
                      titulo: _tituloController.text,
                      descripcion: _descripcionController.text,
                      fechaEntrega: _fechaSeleccionada,
                    );
                    controlador.actualizarTarea(tareaActualizada);
                  } else {
                    final nuevaTarea = Tarea(
                      id: '',
                      idAsignatura: _asignatura!.id,
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
