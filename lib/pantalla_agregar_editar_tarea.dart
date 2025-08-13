import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:task_app/application/controlador_tareas.dart';
import 'package:task_app/models/asignaturas_model.dart';
import 'package:task_app/models/tarea_model.dart';

class PantallaAgregarEditarTarea extends StatefulWidget {
  const PantallaAgregarEditarTarea({super.key});

  @override
  State<PantallaAgregarEditarTarea> createState() => _PantallaAgregarEditarTareaState();
}

class _PantallaAgregarEditarTareaState extends State<PantallaAgregarEditarTarea> {
  final _formKey = GlobalKey<FormState>();
  final _tituloController = TextEditingController();
  final _descripcionController = TextEditingController();
  final _fechaEntregaController = TextEditingController();
  DateTime? _fechaSeleccionada;

  Asignatura? _asignatura;
  Tarea? _tareaParaEditar;
  bool _esEdicion = false;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String, dynamic>?;

    if (args != null) {
      _asignatura = args['asignatura'] as Asignatura?;
      _tareaParaEditar = args['tarea'] as Tarea?;
      _esEdicion = _tareaParaEditar != null;

      if (_esEdicion) {
        _tituloController.text = _tareaParaEditar!.titulo;
        _descripcionController.text = _tareaParaEditar!.descripcion;
        _fechaSeleccionada = _tareaParaEditar!.fechaEntrega;
        if (_fechaSeleccionada != null) {
          _fechaEntregaController.text =
              DateFormat('dd/MM/yyyy').format(_fechaSeleccionada!);
        }
      }
    }
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _descripcionController.dispose();
    _fechaEntregaController.dispose();
    super.dispose();
  }

  Future<void> _seleccionarFecha(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _fechaSeleccionada ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: Theme.of(context).colorScheme.primary,
            )
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _fechaSeleccionada) {
      setState(() {
        _fechaSeleccionada = picked;
        _fechaEntregaController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  void _guardarTarea() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    if (_fechaSeleccionada == null) {
      Get.snackbar(
        'Campo Requerido',
        'Por favor, selecciona una fecha de entrega.',
        backgroundColor: Theme.of(context).colorScheme.error,
        colorText: Colors.white,
      );
      return;
    }
    if (_asignatura == null) {
      Get.snackbar(
        'Error',
        'No se ha proporcionado una asignatura válida.',
        backgroundColor: Theme.of(context).colorScheme.error,
        colorText: Colors.white,
      );
      return;
    }

    final controlador = Get.find<TareaController>();

    if (_esEdicion) {
      final tareaActualizada = _tareaParaEditar!.copyWith(
        titulo: _tituloController.text,
        descripcion: _descripcionController.text,
        fechaEntrega: _fechaSeleccionada,
      );
      controlador.actualizarTarea(tareaActualizada);
    } else {
      final nuevaTarea = Tarea(
        id: '', // Firestore generará el ID
        idAsignatura: _asignatura!.id,
        titulo: _tituloController.text,
        descripcion: _descripcionController.text,
        fechaEntrega: _fechaSeleccionada!,
        estaCompletada: false,
      );
      controlador.agregarTarea(nuevaTarea);
    }
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_esEdicion ? 'Editar Tarea' : 'Nueva Tarea'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _tituloController,
                decoration: const InputDecoration(labelText: 'Título'),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'El título es obligatorio' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descripcionController,
                decoration: const InputDecoration(labelText: 'Descripción (Opcional)'),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _fechaEntregaController,
                decoration: const InputDecoration(
                  labelText: 'Fecha de Entrega',
                  prefixIcon: Icon(Icons.calendar_today_outlined),
                ),
                readOnly: true,
                onTap: () => _seleccionarFecha(context),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Selecciona una fecha' : null,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _guardarTarea,
                child: Text(_esEdicion ? 'Guardar Cambios' : 'Crear Tarea'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}