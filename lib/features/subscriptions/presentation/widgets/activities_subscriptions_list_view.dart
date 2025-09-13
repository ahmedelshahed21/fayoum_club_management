import 'package:fayoum_club_management/core/utils/app_colors.dart';
import 'package:fayoum_club_management/core/widgets/app_indicators.dart';
import 'package:fayoum_club_management/features/subscriptions/data/models/activities_subscriptions_model/activities_subscriptions_model.dart';
import 'package:fayoum_club_management/features/subscriptions/presentation/widgets/activity_subscription_card.dart';
import 'package:flutter/material.dart';


class ActivitiesSubscriptionsListView extends StatelessWidget {
  final List<ActivitySubscriptionItem> items;
  final bool hasMore;
  final ScrollController scrollController;

  const ActivitiesSubscriptionsListView({
    super.key,
    required this.items,
    required this.hasMore,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: scrollController,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16),
      itemCount: hasMore ? items.length + 1 : items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        if (index < items.length) {
          return ActivitySubscriptionCard(item: items[index]);
        } else {
          return  Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(child: PrimaryCircularProgressIndicator(color: AppColors.primaryColor)),
          );
        }
      },
    );
  }
}