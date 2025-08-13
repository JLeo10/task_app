import 'package:flutter/material.dart';
import 'package:task_app/config/theme.dart';

// un checkbox personalizado que sigue nuestra guia de estilo
class CustomCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?>? onChanged;

  const CustomCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged?.call(!value);
      },
      child: Container(
        width: 24.0,
        height: 24.0,
        decoration: BoxDecoration(
          // el color de fondo cambia si esta marcado o no
          color: value ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            // el color del borde tambien cambia
            color: value ? AppColors.primary : AppColors.textSecondary,
            width: 2.0,
          ),
        ),
        // el icono de check solo aparece si esta marcado
        child: value
            ? const Icon(
                Icons.check,
                size: 18.0,
                color: AppColors.background, // el check es del color de fondo para contrastar
              )
            : null,
      ),
    );
  }
}
