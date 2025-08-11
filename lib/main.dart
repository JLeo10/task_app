import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_app/config/app_routes.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Task App',
      debugShowCheckedModeBanner: false, //oculta  debug
      initialRoute: '/login', //app empieza en la pantalla de login
      getPages: AppRutas.rutas, //usa rutas definidas
      theme: ThemeData(primarySwatch: Colors.deepPurple),
    );
  }
}
