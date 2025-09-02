import 'package:fayoum_club_management/core/widgets/app_app_bars.dart';
import 'package:fayoum_club_management/core/widgets/spacing.dart';
import 'package:fayoum_club_management/features/activites/presentation/widgets/add_new_activity_form.dart';
import 'package:flutter/material.dart';


class AddNewActivityView extends StatefulWidget {
  const AddNewActivityView({super.key});

  @override
  State<AddNewActivityView> createState() => _AddNewActivityViewState();
}

class _AddNewActivityViewState extends State<AddNewActivityView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(title: 'إضافة نشاط'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              VerticalSpace(8),
              AddNewActivityForm(),
            ],
          ),
        ),
      ),
    );
  }
}
