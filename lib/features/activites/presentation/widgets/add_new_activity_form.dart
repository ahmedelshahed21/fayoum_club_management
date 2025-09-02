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

class AddNewActivityForm extends StatefulWidget {
  const AddNewActivityForm({super.key});

  @override
  State<AddNewActivityForm> createState() => _AddNewActivityFormState();
}

class _AddNewActivityFormState extends State<AddNewActivityForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController categoryNameController = TextEditingController();
  final TextEditingController reservationDurationController =
      TextEditingController();
  bool byReservation = false;
  File? selectedImage;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ImagePickerWidget(
            onImageSelected: (File? image) {
              setState(() => selectedImage = image);
            },
          ),
          UnderLineInputBorderTextFormField(
            controller: categoryNameController,
            type: TextInputType.name,
            hintText: 'اسم النشاط',
          ),
          const VerticalSpace(24),
          // Align(
          //   alignment: Alignment.topRight,
          //   child: Text(
          //     'الوصف',
          //     style: AppStyles.styleBold18(
          //       context,
          //     ).copyWith(color: AppColors.pureBlackColor),
          //     textAlign: TextAlign.start,
          //   ),
          // ),
          // const VerticalSpace(8),


          Align(
            alignment: Alignment.topRight,
            child: Text(
              'قيمة الاشتراك',
              style: AppStyles.styleBold18(
                context,
              ).copyWith(color: AppColors.pureBlackColor),
              textAlign: TextAlign.start,
            ),
          ),
          const VerticalSpace(8),
          Row(
            children: [
              Expanded(
                child: OutLineInputBorderTextFormField(
                  hintText: 'للأعضاء',
                  type: TextInputType.number,
                ),
              ),
              HorizontalSpace(8),
              Expanded(
                child: OutLineInputBorderTextFormField(
                  hintText: 'لغير لأعضاء',
                  type: TextInputType.number,
                ),
              ),
            ],
          ),
          const VerticalSpace(24),
          OutLineInputBorderTextFormField(
            hintText: 'الوصف',
            type: TextInputType.number,
            minLines: 5,
            maxLength: 7,
          ),

          const VerticalSpace(64),
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
                );
                return; // Prevent further execution
              }
            },
            text: AppStrings.save.tr(),
          ),
        ],
      ),
    );
  }
}
