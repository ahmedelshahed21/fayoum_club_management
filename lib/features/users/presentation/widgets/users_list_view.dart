import 'package:fayoum_club_management/core/widgets/app_indicators.dart';
import 'package:fayoum_club_management/features/users/presentation/widgets/user_card.dart';
import 'package:flutter/material.dart';

class UsersListView extends StatelessWidget {
  final List items;
  final bool hasMore;
  final ScrollController scrollController;

  const UsersListView({
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: hasMore ? items.length + 1 : items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        if (index < items.length) {
          return UserCard(item: items[index]);
        } else {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: Center(child: PrimaryCircularProgressIndicator()),
          );
        }
      },
    );
  }
}