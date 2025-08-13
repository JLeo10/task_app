import 'package:flutter/material.dart';

// este es nuestro campo de texto reutilizable
class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final bool readOnly; // nuevo parametro para hacer el campo de solo lectura
  final GestureTapCallback? onTap; // nuevo parametro para manejar taps

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.validator,
    this.obscureText = false,
    this.keyboardType,
    this.suffixIcon,
    this.readOnly = false, // valor por defecto
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // el textformfield toma su estilo del inputdecorationtheme en el tema global
    // no es necesario decorar el widget aqui
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      keyboardType: keyboardType,
      readOnly: readOnly, // pasamos el parametro a textformfield
      onTap: onTap, // pasamos el parametro a textformfield
      decoration: InputDecoration(
        labelText: label, // usamos labeltext en lugar de hinttext para una mejor ux
        suffixIcon: suffixIcon,
        // el resto de propiedades como color de fondo bordes y padding vienen del tema
      ),
    );
  }
}
