import 'package:fayoum_club_management/core/constants/app_colors.dart';
import 'package:fayoum_club_management/core/constants/app_styles.dart';
import 'package:fayoum_club_management/core/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:fayoum_club_management/core/widgets/clickable_text.dart';

class HaveAnAccount extends StatelessWidget {
  const HaveAnAccount({
    super.key,
    required this.text,
    required this.textButton,
    required this.onPressed,
  });

  final String text;
  final String textButton;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: AppStyles.styleRegular16(
            context,
          ).copyWith(color: AppColors.offGreyColor, fontSize: 14),
        ),
        const HorizontalSpace(8),
        ClickableText(
          onTap: onPressed,
          text: textButton,
          textStyle: AppStyles.styleSemiBold16(
            context,
          ).copyWith(color: AppColors.primaryColor),
        ),
      ],
    );
  }
}
