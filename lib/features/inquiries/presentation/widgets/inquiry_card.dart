import 'package:fayoum_club_management/core/utils/app_colors.dart';
import 'package:fayoum_club_management/core/widgets/spacing.dart';
import 'package:fayoum_club_management/features/inquiries/presentation/widgets/inquiry_details.dart';
import 'package:fayoum_club_management/features/inquiries/presentation/widgets/inquiry_header.dart';
import 'package:fayoum_club_management/features/inquiries/presentation/widgets/inquiry_time.dart';
import 'package:flutter/material.dart';

class InquiryCard extends StatelessWidget {
  final dynamic item;

  const InquiryCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.pureWhiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 0.2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InquiryHeader(item: item),
            const VerticalSpace(8),
            InquiryDetails(item: item),
            const VerticalSpace(8),
            InquiryTime(item: item),
          ],
        ),
      ),
    );
  }
}
