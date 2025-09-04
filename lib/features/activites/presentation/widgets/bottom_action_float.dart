import 'package:fayoum_club_management/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class ButtonActionFloat extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const ButtonActionFloat({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 60,
        height: 60,
        child: FloatingActionButton(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: Colors.white,
          onPressed: onPressed,
          child: Icon(icon, size: 30),
        ),
      ),
    );
  }
}
