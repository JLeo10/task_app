import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_app/config/app_routes.dart';
import 'package:task_app/config/theme.dart'; // importamos nuestro tema personalizado
import 'package:task_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // inicializar Firebase en nuestra aplicación
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Task App',
      debugShowCheckedModeBanner: false, //oculta  debug
      initialRoute: '/login', //app empieza en la pantalla de login
      getPages: AppRutas.rutas, //usa rutas definidas
      theme: darkTheme, // aplicamos el tema oscuro personalizado
    );
  }
}
