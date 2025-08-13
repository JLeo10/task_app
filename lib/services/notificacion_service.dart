import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    // Inicializar timezone
    tz.initializeTimeZones();
    
    // Configuración para Android
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
        
    // Configuración para iOS
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) async {},
    );
        
    // Configuración inicial combinada
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );
    
    // Inicializar el plugin
    await _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse details) async {},
    );

    // Configurar la zona horaria local
    await _configureLocalTimeZone();
  }

  static Future<void> _configureLocalTimeZone() async {
    try {
      final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(timeZoneName));
    } catch (e) {
      print('Error configurando zona horaria: $e');
      tz.setLocalLocation(tz.getLocation('UTC'));
    }
  }

  static Future<void> mostrarNotificacionInstantanea({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    try {
      await _notificationsPlugin.show(
        id,
        title,
        body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'task_app_channel',
            'Recordatorios de Tareas',
            channelDescription: 'Canal para notificaciones de tareas universitarias',
            importance: Importance.max,
            priority: Priority.high,
            playSound: true,
          ),
          iOS: DarwinNotificationDetails(),
        ),
        payload: payload,
      );
    } catch (e) {
      print('Error mostrando notificación: $e');
    }
  }

  static Future<void> programarNotificacion({
    required int id,
    required String title,
    required String body,
    required DateTime fecha,
    String? payload,
  }) async {
    try {
      await _notificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(fecha, tz.local),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'task_app_channel',
            'Recordatorios de Tareas',
            channelDescription: 'Canal para notificaciones de tareas universitarias',
            importance: Importance.max,
            priority: Priority.high,
            playSound: true,
          ),
          iOS: DarwinNotificationDetails(),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
        payload: payload,
      );
    } catch (e) {
      print('Error programando notificación: $e');
    }
  }

  static Future<void> cancelarNotificacion(int id) async {
    try {
      await _notificationsPlugin.cancel(id);
    } catch (e) {
      print('Error cancelando notificación: $e');
    }
  }

  static Future<void> cancelarTodasLasNotificaciones() async {
    try {
      await _notificationsPlugin.cancelAll();
    } catch (e) {
      print('Error cancelando todas las notificaciones: $e');
    }
  }
}