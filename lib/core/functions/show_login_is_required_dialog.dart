import 'package:fayoum_club_management/core/widgets/login_is_required_dialog_widget.dart';
import 'package:flutter/material.dart';

void showLoginIsRequiredDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return const LoginIsRequiredDialogWidget();
    },
  );
}
