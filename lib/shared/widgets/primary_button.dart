import 'package:flutter/material.dart';

// este es nuestro boton principal reutilizable
class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const PrimaryButton({
    super.key, 
    required this.text, 
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    // usamos un sizedbox para que el boton ocupe todo el ancho disponible
    return SizedBox(
      width: double.infinity,
      // el elevatedbutton toma su estilo directamente del tema global
      // no es necesario definir colores o formas aqui
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}

