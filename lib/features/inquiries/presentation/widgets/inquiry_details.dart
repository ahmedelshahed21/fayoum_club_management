import 'package:fayoum_club_management/core/utils/app_colors.dart';
import 'package:fayoum_club_management/core/utils/app_styles.dart';
import 'package:flutter/material.dart';

class InquiryDetails extends StatelessWidget {
  final dynamic item;

  const InquiryDetails({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.lightGreyColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
          bottomLeft: Radius.circular(8),
        ),
      ),
      child: Text(
        item.details,
        style: AppStyles.styleSemiBold14(
          context,
        ).copyWith(color: AppColors.blueColor.withValues(alpha: 0.8)),
      ),
    );
  }
}