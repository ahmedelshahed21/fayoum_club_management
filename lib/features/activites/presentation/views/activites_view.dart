import 'package:fayoum_club_management/core/widgets/spacing.dart';
import 'package:fayoum_club_management/features/activites/presentation/widgets/activities_vertical_list_view_section.dart';
import 'package:flutter/material.dart';

class ActivitesView extends StatelessWidget {
  const ActivitesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          VerticalSpace(16),
          Expanded(child: ActivitiesVerticalListViewSection()),
        ],
      ),
    );
  }
}
