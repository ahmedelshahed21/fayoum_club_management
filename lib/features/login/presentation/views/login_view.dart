import 'package:fayoum_club_management/core/constants/app_strings.dart';
import 'package:fayoum_club_management/core/widgets/app_name_and_logo_widget.dart';
import 'package:fayoum_club_management/core/widgets/spacing.dart';
import 'package:fayoum_club_management/features/login/presentation/widgets/login_form.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';


class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const VerticalSpace(16),
              AppNameAndLogoWidget(title: AppStrings.welcomeBack.tr()),
              const VerticalSpace(12),
              const LoginForm(),
            ],
          ),
        ),
      ),
    );
  }
}
