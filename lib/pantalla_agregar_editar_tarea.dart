import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_app/application/controlador_asignaturas.dart';
import 'package:task_app/application/controlador_tareas.dart';
import 'package:task_app/config/theme.dart';
import 'package:task_app/models/asignaturas_model.dart';
import 'package:task_app/models/tarea_model.dart';
import 'package:task_app/shared/widgets/custom_textfield.dart';
import 'package:task_app/shared/widgets/primary_button.dart';

// pantalla para crear o editar una tarea
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
  bool esEdicion = false;

  @override
  void initState() {
    super.initState();
    // determinamos si estamos editando o creando una tarea nueva
    final args = Get.arguments;
    if (args is Asignatura) {
      _asignatura = args;
      esEdicion = false;
    } else if (args is Tarea) {
      _tareaParaEditar = args;
      esEdicion = true;
      _asignatura = Get.find<AsignaturaController>().asignaturas.firstWhereOrNull((a) => a.id == _tareaParaEditar?.idAsignatura);
      _tituloController.text = _tareaParaEditar?.titulo ?? '';
      _descripcionController.text = _tareaParaEditar?.descripcion ?? '';
      _fechaSeleccionada = _tareaParaEditar?.fechaEntrega;
      if (_fechaSeleccionada != null) {
        _fechaEntregaController.text = DateFormat('dd/MM/yyyy').format(_fechaSeleccionada!);
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

  // funcion para mostrar el selector de fecha
  Future<void> _seleccionarFecha(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _fechaSeleccionada ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      // aplicamos el tema personalizado al datepicker
      builder: (context, child) {
        return Theme(
          data: darkTheme.copyWith(
            colorScheme: darkTheme.colorScheme.copyWith(
              surface: AppColors.surface,
              onSurface: AppColors.textPrimary,
            ),
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

  // funcion para guardar la tarea
  void _guardarTarea() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    if (_fechaSeleccionada == null) {
      Get.snackbar('Error', 'Debes seleccionar una fecha de entrega.', backgroundColor: AppColors.surface, colorText: AppColors.textPrimary);
      return;
    }
    if (_asignatura == null) {
      Get.snackbar('Error', 'La asignatura no se pudo cargar.', backgroundColor: AppColors.surface, colorText: AppColors.textPrimary);
      return;
    }

    final controlador = Get.find<TareaController>();
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(esEdicion ? 'Editar Tarea' : 'Nueva Tarea'),
        backgroundColor: AppColors.background.withAlpha((255 * 0.8).round()), // usando withAlpha en lugar de withOpacity
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // campo para el titulo
              CustomTextField(
                controller: _tituloController,
                label: 'Título',
                validator: (v) => v == null || v.isEmpty ? 'el título es obligatorio' : null,
              ),
              const SizedBox(height: 16),
              // campo para la descripcion
              CustomTextField(
                controller: _descripcionController,
                label: 'Descripción (opcional)',
              ),
              const SizedBox(height: 16),
              // campo para la fecha de entrega
              CustomTextField(
                controller: _fechaEntregaController,
                label: 'Fecha de Entrega',
                readOnly: true,
                onTap: () => _seleccionarFecha(context),
                suffixIcon: const Icon(Icons.calendar_today_rounded, color: AppColors.textSecondary),
              ),
              const SizedBox(height: 32),
              // boton para guardar
              PrimaryButton(
                text: esEdicion ? 'Guardar Cambios' : 'Guardar Tarea',
                onPressed: _guardarTarea,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
