import 'package:fayoum_club_management/core/widgets/app_app_bars.dart';
import 'package:fayoum_club_management/core/widgets/spacing.dart';
import 'package:fayoum_club_management/features/trainers/presentation/widgets/add_new_trainer_form.dart';
import 'package:flutter/material.dart';

class AddNewTrainerView extends StatelessWidget {
  const AddNewTrainerView({super.key, required this.activityId});

  final int activityId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(title: 'إضافة مدرب جديد'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(children: [VerticalSpace(16), AddNewTrainerForm(activityId: activityId)]),
        ),
      ),
    );
  }
}
