import 'package:fayoum_club_management/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:fayoum_club_management/features/splash/presentation/widgets/splash_view_body.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SplashViewBody(),
    );
  }
}
