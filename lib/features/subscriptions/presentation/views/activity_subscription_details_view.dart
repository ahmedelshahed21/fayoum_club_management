import 'package:easy_localization/easy_localization.dart';
import 'package:fayoum_club_management/core/functions/open_call_url.dart';
import 'package:fayoum_club_management/core/utils/app_colors.dart';
import 'package:fayoum_club_management/core/utils/app_strings.dart';
import 'package:fayoum_club_management/core/utils/app_styles.dart';
import 'package:fayoum_club_management/core/widgets/app_app_bars.dart';
import 'package:fayoum_club_management/core/widgets/app_buttons.dart';
import 'package:fayoum_club_management/core/widgets/price_widget.dart';
import 'package:fayoum_club_management/core/widgets/spacing.dart';
import 'package:fayoum_club_management/features/subscriptions/data/models/activities_subscriptions_model/activities_subscriptions_model.dart';
import 'package:flutter/material.dart';

class ActivitySubscriptionDetailsView extends StatelessWidget {
  final ActivitySubscriptionItem item;

  const ActivitySubscriptionDetailsView({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat(
      'dd/MM/yyyy  HH:mm',
      'en',
    ).format(item.createdAt!);

    return Scaffold(
      appBar: PrimaryAppBar(
        title: '',
        backgroundColor: AppColors.offWhiteColor,
        iconColor: AppColors.primaryColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "# ${item.numberCode}",
              style: AppStyles.styleBold24(
                context,
              ).copyWith(color: AppColors.greyColor),
            ),
            VerticalSpace(8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 28),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.blueColor.withValues(alpha: 0.08),
              ),
              child: PriceWidget(
                price: item.moneyPay.toString(),
                priceStyle: AppStyles.styleExtraBold28(
                  context,
                ).copyWith(color: AppColors.blueColor),
                currency: "ج.م",
              ),
            ),
            VerticalSpace(24),
            Text(
              item.activity.title,
              style: AppStyles.styleExtraBold28(
                context,
              ).copyWith(color: AppColors.primaryColor),
            ),
            VerticalSpace(32),
            _buildInfoRow(context, AppStrings.name.tr(), item.user.name),
            _buildInfoRow(
              context,
              AppStrings.phoneNumber.tr(),
              item.user.phone,
            ),
            _buildInfoRow(context, "التاريخ", formattedDate),
            VerticalSpace(6),

            VerticalSpace(200),
            PrimaryButton(
              text: "اتصال بالعميل",
              onPressed: () {
                openCallUrl(context, "+20", item.user.phone);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: Row(
        children: [
          Text(
            label,
            style: AppStyles.styleSemiBold12(
              context,
            ).copyWith(color: AppColors.greyColor),
          ),
          const Spacer(),
          Expanded(
            flex: 2,
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: AppStyles.styleBold18(
                context,
              ).copyWith(color: AppColors.pureBlackColor),
            ),
          ),
        ],
      ),
    );
  }
}
