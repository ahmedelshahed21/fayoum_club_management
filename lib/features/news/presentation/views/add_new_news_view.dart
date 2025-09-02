import 'package:fayoum_club_management/core/widgets/app_app_bars.dart';
import 'package:fayoum_club_management/core/widgets/spacing.dart';
import 'package:fayoum_club_management/features/news/presentation/widgets/add_new_news_form.dart';
import 'package:flutter/material.dart';


class AddNewNewsView extends StatelessWidget {
  const AddNewNewsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(title: 'إضافة خبر جديد'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              VerticalSpace(16),
              AddNewNewsForm(),
            ],
          ),
        ),
      ),
    );
  }
}
