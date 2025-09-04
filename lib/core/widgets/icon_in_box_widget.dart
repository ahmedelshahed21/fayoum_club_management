import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class IconInBoxWidget extends StatelessWidget {
  const IconInBoxWidget({super.key, required this.child, this.size});

  final Widget child;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size ?? 38,
      width: size ?? 38,
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(child: child),
    );
  }
}
