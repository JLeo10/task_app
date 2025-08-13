
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:task_app/application/controlador_tareas.dart';
import 'package:task_app/models/tarea_model.dart';
import 'package:intl/intl.dart';

class PantallaCalendario extends StatefulWidget {
  final String asignaturaId;

  const PantallaCalendario({Key? key, required this.asignaturaId}) : super(key: key);

  @override
  State<PantallaCalendario> createState() => _PantallaCalendarioState();
}

class _PantallaCalendarioState extends State<PantallaCalendario> {
  late final TareaController tareaController;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    tareaController = Get.put(TareaController(asignaturaId: widget.asignaturaId));
    _selectedDay = _focusedDay;
  }

  List<Tarea> _getTareasForDay(DateTime day) {
    return tareaController.tareas.where((tarea) {
      return isSameDay(tarea.fechaEntrega, day);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendario de Tareas'),
      ),
      body: Column(
        children: [
          TableCalendar(
            locale: 'es_ES', // Set locale to Spanish
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay; // update `_focusedDay` here as well
              });
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            eventLoader: _getTareasForDay,
            calendarStyle: const CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.blueGrey,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              markerDecoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
            ),
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
            ),
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: Obx(() {
              if (tareaController.estaCargando.value) {
                return const Center(child: CircularProgressIndicator());
              }

              final selectedTareas = _getTareasForDay(_selectedDay!);

              if (selectedTareas.isEmpty) {
                return Center(child: Text('No hay tareas para el ${DateFormat('dd/MM/yyyy').format(_selectedDay!)}'));
              }

              return ListView.builder(
                itemCount: selectedTareas.length,
                itemBuilder: (context, index) {
                  final tarea = selectedTareas[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    child: ListTile(
                      title: Text(tarea.titulo),
                      subtitle: Text(
                        '${tarea.descripcion} - ${DateFormat('dd/MM/yyyy HH:mm').format(tarea.fechaEntrega)}',
                      ),
                      trailing: Icon(
                        tarea.estaCompletada ? Icons.check_box : Icons.check_box_outline_blank,
                        color: tarea.estaCompletada ? Colors.green : Colors.grey,
                      ),
                      onTap: () {
                        // TODO: Implement navigation to task detail or edit screen
                      },
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
