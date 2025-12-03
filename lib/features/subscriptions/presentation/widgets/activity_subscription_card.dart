import 'package:easy_localization/easy_localization.dart';
import 'package:fayoum_club_management/core/utils/app_colors.dart';
import 'package:fayoum_club_management/core/utils/app_styles.dart';
import 'package:fayoum_club_management/core/widgets/price_widget.dart';
import 'package:fayoum_club_management/core/widgets/spacing.dart';
import 'package:fayoum_club_management/features/subscriptions/data/models/activities_subscriptions_model/activities_subscriptions_model.dart';
import 'package:fayoum_club_management/features/subscriptions/presentation/views/activity_subscription_details_view.dart';
import 'package:flutter/material.dart';

class ActivitySubscriptionCard extends StatelessWidget {
  final ActivitySubscriptionItem item;

  const ActivitySubscriptionCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat(
      'dd/MM/yyyy  HH:mm',
      'en',
    ).format(item.createdAt!);

    return InkWell(
        borderRadius: BorderRadius.circular(8),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ActivitySubscriptionDetailsView(item: item),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 1,
        color: AppColors.pureWhiteColor,
        shadowColor: AppColors.lightGreyColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: Column(
            children: [
              Text('# ${item.numberCode}',
                style: AppStyles.styleBold20(context).copyWith(color: AppColors.greyColor),
              ),
              VerticalSpace(12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.user.name,
                            style: AppStyles.styleSemiBold16(
                              context,
                            ).copyWith(color: AppColors.pureBlackColor),
                          ),
                          VerticalSpace(4),
                          Text(
                            item.user.phone,
                            style: AppStyles.styleSemiBold16(
                              context,
                            ).copyWith(color: AppColors.greyColor),
                          ),
                          VerticalSpace(4),
                        ],
                      ),
                      Spacer(),
                      Container(
                        padding:  EdgeInsets.symmetric(horizontal: 12,vertical: 16),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.blueColor.withValues(alpha: 0.1),
                        ),
                        child: PriceWidget(
                          price: item.moneyPay.toString(),
                          priceStyle: AppStyles.styleBold18(context).copyWith(color: AppColors.blueColor),
                          currency: "ج.م",
                        ),
                      ),
                    ],
                  ),
                  VerticalSpace(12),
                  Text(
                    item.activity.title,
                    style: AppStyles.styleSemiBold16(
                      context,
                    ).copyWith(color: AppColors.primaryColor),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      formattedDate,
                      style: AppStyles.styleRegular14(
                        context,
                      ).copyWith(color: AppColors.customGreyColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
