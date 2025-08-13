
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_app/application/controlador_tareas.dart';
import 'package:task_app/models/tarea_model.dart';
import 'package:intl/intl.dart';

class PantallaVistaSemanal extends StatelessWidget {
  final String asignaturaId; // Necesitamos el ID de la asignatura para filtrar tareas

  const PantallaVistaSemanal({super.key, required this.asignaturaId});

  @override
  Widget build(BuildContext context) {
    // Inicializa el controlador de tareas para esta asignatura
    final TareaController tareaController = Get.put(TareaController(asignaturaId: asignaturaId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vista Semanal de Tareas'),
      ),
      body: Obx(() {
        if (tareaController.estaCargando.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (tareaController.tareas.isEmpty) {
          return const Center(child: Text('No hay tareas para esta asignatura.'));
        }

        // Agrupar tareas por día de la semana
        final Map<String, List<Tarea>> tareasPorDia = {};
        for (var tarea in tareaController.tareas) {
          final String diaSemana = DateFormat('EEEE, dd MMMM', 'es').format(tarea.fechaEntrega);
          if (!tareasPorDia.containsKey(diaSemana)) {
            tareasPorDia[diaSemana] = [];
          }
          tareasPorDia[diaSemana]!.add(tarea);
        }

        // Ordenar los días de la semana
        final List<String> diasOrdenados = tareasPorDia.keys.toList()
          ..sort((a, b) => DateFormat('EEEE, dd MMMM', 'es').parse(a).compareTo(DateFormat('EEEE, dd MMMM', 'es').parse(b)));

        return ListView.builder(
          itemCount: diasOrdenados.length,
          itemBuilder: (context, index) {
            final String dia = diasOrdenados[index];
            final List<Tarea> tareasDelDia = tareasPorDia[dia]!;

            return Card(
              margin: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dia,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ...tareasDelDia.map((tarea) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        children: [
                          Icon(
                            tarea.estaCompletada ? Icons.check_box : Icons.check_box_outline_blank,
                            color: tarea.estaCompletada ? Colors.green : Colors.grey,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              tarea.titulo,
                              style: TextStyle(
                                decoration: tarea.estaCompletada ? TextDecoration.lineThrough : null,
                              ),
                            ),
                          ),
                          Text(DateFormat('HH:mm').format(tarea.fechaEntrega)),
                        ],
                      ),
                    )),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
