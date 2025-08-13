import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:task_app/config/theme.dart';

// un widget de tarjeta con efecto de vidrio esmerilado
class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const GlassCard({super.key, required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      // usamos cliprrect para asegurar que el efecto de desenfoque respete los bordes redondeados
      borderRadius: BorderRadius.circular(12.0),
      child: BackdropFilter(
        // este es el filtro que crea el efecto de desenfoque
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          padding: padding ?? const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            // color de la tarjeta con opacidad para el efecto de transparencia
            color: AppColors.surface.withAlpha((255 * 0.5).round()), // usando withAlpha en lugar de withOpacity
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              // borde sutil para definir la tarjeta
              color: AppColors.border.withAlpha((255 * 0.3).round()), // usando withAlpha en lugar de withOpacity
              width: 1.5,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
