import 'package:fayoum_club_management/core/functions/open_call_url.dart';
import 'package:fayoum_club_management/core/utils/app_colors.dart';
import 'package:fayoum_club_management/core/utils/app_styles.dart';
import 'package:fayoum_club_management/core/widgets/icon_in_box_widget.dart';
import 'package:flutter/material.dart';

class InquiryHeader extends StatelessWidget {
  final dynamic item;

  const InquiryHeader({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(item.name, style: AppStyles.styleBold18(context).copyWith(color: AppColors.pureBlackColor)),
      subtitle: Text(
        item.phone,
        style: AppStyles.styleSemiBold16(
          context,
        ).copyWith(color: AppColors.greyColor),
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