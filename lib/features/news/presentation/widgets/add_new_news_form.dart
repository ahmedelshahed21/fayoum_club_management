import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:fayoum_club_management/core/constants/app_colors.dart';
import 'package:fayoum_club_management/core/constants/app_strings.dart';
import 'package:fayoum_club_management/core/constants/app_styles.dart';
import 'package:fayoum_club_management/core/functions/app_snack_bars.dart';
import 'package:fayoum_club_management/core/widgets/app_buttons.dart';
import 'package:fayoum_club_management/core/widgets/app_text_fields.dart';
import 'package:fayoum_club_management/core/widgets/spacing.dart';
import 'package:fayoum_club_management/core/widgets/image_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class AddNewNewsForm extends StatefulWidget {
  const AddNewNewsForm({super.key});

  @override
  State<AddNewNewsForm> createState() => _AddNewNewsFormState();
}

class _AddNewNewsFormState extends State<AddNewNewsForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController categoryNameController = TextEditingController();
  final TextEditingController reservationDurationController =
      TextEditingController();
  File? selectedImage;
  bool isUrgent = false;
  String? newsType;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: ImagePickerWidget(
              onImageSelected: (File? image) {
                setState(() => selectedImage = image);
              },
            ),
          ),
          UnderLineInputBorderTextFormField(
            controller: categoryNameController,
            type: TextInputType.name,
            hintText: 'عنوان الخبر',
          ),
          const VerticalSpace(24),
          OutLineInputBorderTextFormField(
            hintText: 'تفاصيل الخبر',
            type: TextInputType.multiline,
            minLines: 5,
            maxLength: 500,
          ),
          const VerticalSpace(16),
          Text("نوع الخبر", style: AppStyles.styleBold14(context)),
          Row(
            children: [
              Expanded(
                child: RadioListTile<String>(
                  activeColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  title: const Text("Practice"),
                  value: "practice",
                  groupValue: newsType,
                  contentPadding: EdgeInsets.zero,
                  onChanged: (val) {
                    setState(() => newsType = val);
                  },
                ),
              ),
              HorizontalSpace(4),
              Expanded(
                child: RadioListTile<String>(
                  activeColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  title: const Text("Competition"),
                  value: "competition",
                  groupValue: newsType,
                  contentPadding: EdgeInsets.zero,
                  onChanged: (val) {
                    setState(() => newsType = val);
                  },
                ),
              ),
            ],
          ),
          const VerticalSpace(4),
          Row(
            children: [
              Checkbox(
                activeColor: AppColors.redColor,
                side: BorderSide(color: AppColors.redColor, width: 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                value: isUrgent,
                onChanged: (val) {
                  setState(() => isUrgent = val ?? false);
                },
              ),
              Text(
                "عاجل",
                style: AppStyles.styleSemiBold18(
                  context,
                ).copyWith(color: AppColors.redColor),
              ),
            ],
          ),
          const VerticalSpace(32),
          PrimaryButton(
            onPressed: () {
              FocusScope.of(context).unfocus();
              if (selectedImage == null) {
                primarySnackBar(
                  context,
                  'يجب تحديد صورة',
                  icon: Iconsax.danger,
                  iconSize: 32,
                  iconColor: Colors.yellow,
                  boxColor: AppColors.pureBlackColor,
                );
                return;
              }
              // // تحويل القيمة لـ int (1 لو عاجل، 0 لو مش عاجل)
              // int urgentValue = isUrgent ? 1 : 0;
              //
              // // هنا تقدر تبعت البيانات للـ API
              // print("عنوان الخبر: ${categoryNameController.text}");
              // print("هل عاجل: $urgentValue");
              // print("نوع الخبر: $newsType");
            },
            text: AppStrings.save.tr(),
          ),
        ],
      ),
    );
  }
}
