import 'package:easy_localization/easy_localization.dart';
import 'package:fayoum_club_management/core/functions/open_call_url.dart';
import 'package:fayoum_club_management/core/utils/app_colors.dart';
import 'package:fayoum_club_management/core/utils/app_styles.dart';
import 'package:fayoum_club_management/core/widgets/icon_in_box_widget.dart';
import 'package:fayoum_club_management/core/widgets/spacing.dart';
import 'package:flutter/material.dart';

/// =====================
/// Widget: InquiryCard
/// =====================
class InquiryCard extends StatelessWidget {
  final dynamic item;

  const InquiryCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.pureWhiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 0.5,
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

/// =====================
/// Widget: InquiryHeader
/// =====================
class InquiryHeader extends StatelessWidget {
  final dynamic item;

  const InquiryHeader({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(item.name, style: AppStyles.styleSemiBold16(context)),
      subtitle: Text(
        item.phone,
        style: AppStyles.styleRegular14(
          context,
        ).copyWith(color: AppColors.customGreyColor),
      ),
      trailing: IconInBoxWidget(
        size: 50,
        child: IconButton(
          icon: Icon(Icons.call, color: AppColors.greenColor, size: 32),
          onPressed: () {
            openCallUrl(context, "", item.phone);
          },
        ),
      ),
    );
  }
}

/// =====================
/// Widget: InquiryDetails
/// =====================
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

/// =====================
/// Widget: InquiryTime
/// =====================
class InquiryTime extends StatelessWidget {
  final dynamic item;

  const InquiryTime({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat(
      'dd/MM/yyyy  HH:mm',
      'en',
    ).format(item.createdAt);
    return Align(
      alignment: Alignment.bottomLeft,
      child: Text(
        formattedDate,
        style: AppStyles.styleRegular14(
          context,
        ).copyWith(color: AppColors.customGreyColor),
      ),
    );
  }
}