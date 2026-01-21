import 'package:fayoum_club_management/core/utils/app_colors.dart';
import 'package:fayoum_club_management/core/utils/app_styles.dart';
import 'package:fayoum_club_management/core/widgets/spacing.dart';
import 'package:flutter/material.dart';

class UsersTotalHeader extends StatelessWidget {
  final int total;

  const UsersTotalHeader({super.key, required this.total});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.people_alt_outlined,
              color: AppColors.primaryColor,
              size: 32,
            ),
          ),
          const HorizontalSpace(12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'إجمالي عدد المستخدمين المسجلين',
                style: AppStyles.styleSemiBold14(context).copyWith(color: AppColors.primaryColor),
              ),
              const VerticalSpace(6),
              TweenAnimationBuilder<int>(
                tween: IntTween(begin: 0, end: total),
                duration: const Duration(milliseconds: 1600),
                builder: (context, value, _) {
                  return Text(
                    value.toString(),
                    style: AppStyles.styleExtraBold32(context).copyWith(color: AppColors.primaryColor),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}