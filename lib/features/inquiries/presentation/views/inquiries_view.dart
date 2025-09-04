import 'package:fayoum_club_management/core/utils/app_colors.dart';
import 'package:fayoum_club_management/core/utils/app_styles.dart';
import 'package:fayoum_club_management/core/functions/open_call_url.dart';
import 'package:fayoum_club_management/core/widgets/icon_in_box_widget.dart';
import 'package:fayoum_club_management/core/widgets/spacing.dart';
import 'package:flutter/material.dart';

class InquiriesView extends StatelessWidget {
  const InquiriesView({super.key});

  @override
  Widget build(BuildContext context) {
    final inquiries = [
      {
        "name": "Ahmed Mohamed",
        "phone": "+201234567890",
        "inquiry": "عايز اعرف مواعيد التمارين.",
        "time": "2025-09-04 20:15"
      },
      {
        "name": "Mona Ali",
        "phone": "+201098765432",
        "inquiry": "هل فيه خصومات للطلبة؟",
        "time": "2025-09-04 19:50"
      },
    ];

    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16),
      itemCount: inquiries.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final item = inquiries[index];
        return Card(
          color: AppColors.pureWhiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 0.5,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// الاسم + زر الاتصال
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  // leading: CircleAvatar(
                  //   radius: 32,
                  //   backgroundColor: AppColors.primaryColor.withValues(alpha: 0.1),
                  //   child: Text(
                  //     item["name"]![0], // أول حرف من الاسم
                  //     style: AppStyles.styleBold20(context).copyWith(
                  //       color: AppColors.primaryColor,
                  //     ),
                  //   ),
                  // ),
                  title: Text(
                    item["name"]!,
                    style: AppStyles.styleSemiBold16(context),
                  ),
                  subtitle: Text(
                    item["phone"]!,
                    style: AppStyles.styleRegular14(context).copyWith(
                      color: AppColors.customGreyColor,
                    ),
                  ),
                  trailing: IconInBoxWidget(
                    size: 50,
                    child: IconButton(
                      icon: Icon(Icons.call, color: AppColors.greenColor,size: 32),
                      onPressed: () {
                        openCallUrl(context, "", item["phone"]!);
                      },
                    ),
                  ),
                ),



                /// الاستفسار
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.lightGreyColor,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(8),bottomRight: Radius.circular(8),bottomLeft: Radius.circular(8)),
                  ),
                  child: Text(
                    item["inquiry"]!,
                    style: AppStyles.styleSemiBold14(context).copyWith(color: AppColors.blueColor.withValues(alpha: 0.8)),
                  ),
                ),

                VerticalSpace(8),

                /// وقت الإرسال
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    item["time"]!,
                    style: AppStyles.styleRegular14(context).copyWith(
                      color: AppColors.customGreyColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}