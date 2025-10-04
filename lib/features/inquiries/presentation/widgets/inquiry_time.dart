import 'package:easy_localization/easy_localization.dart';
import 'package:fayoum_club_management/core/utils/app_colors.dart';
import 'package:fayoum_club_management/core/utils/app_styles.dart';
import 'package:flutter/material.dart';

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