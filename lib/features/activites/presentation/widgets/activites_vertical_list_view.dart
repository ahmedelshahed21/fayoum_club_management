import 'package:fayoum_club_management/features/activites/data/models/activites_model/activites_model.dart';
import 'package:fayoum_club_management/features/activites/presentation/widgets/activity_card.dart';
import 'package:flutter/material.dart';

class ActivitesListView extends StatelessWidget {
  const ActivitesListView({super.key, required this.activites});

  final List<ActivityItem> activites;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: activites.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(top: 32),
          child: ActivityCard(activityItem: activites[index]),
        );
      },
    );
  }
}
