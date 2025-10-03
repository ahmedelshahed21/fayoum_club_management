import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:fayoum_club_management/core/utils/app_colors.dart';
import 'package:fayoum_club_management/core/utils/app_constants.dart';
import 'package:fayoum_club_management/core/utils/app_strings.dart';
import 'package:fayoum_club_management/core/utils/app_styles.dart';
import 'package:fayoum_club_management/core/functions/app_snack_bars.dart';
import 'package:fayoum_club_management/core/services/service_locator.dart';
import 'package:fayoum_club_management/core/widgets/app_buttons.dart';
import 'package:fayoum_club_management/core/widgets/app_indicators.dart';
import 'package:fayoum_club_management/core/widgets/app_text_fields.dart';
import 'package:fayoum_club_management/core/widgets/dropdown_widget.dart';
import 'package:fayoum_club_management/core/widgets/spacing.dart';
import 'package:fayoum_club_management/core/widgets/image_picker_widget.dart';
import 'package:fayoum_club_management/features/activites/data/models/add_new_activity_model/add_new_activity_request_model.dart';
import 'package:fayoum_club_management/features/activites/presentation/manager/activites_cubit/activites_cubit.dart';
import 'package:fayoum_club_management/features/activites/presentation/manager/add_new_activity_cubit/add_new_activity_cubit.dart';
import 'package:fayoum_club_management/features/activites/presentation/manager/add_new_activity_cubit/add_new_activity_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AddNewActivityForm extends StatefulWidget {
  const AddNewActivityForm({super.key});

  @override
  State<AddNewActivityForm> createState() => _AddNewActivityFormState();
}

class _AddNewActivityFormState extends State<AddNewActivityForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController categoryNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController memberPriceController = TextEditingController();
  final TextEditingController guestPriceController = TextEditingController();

  File? selectedImage;
  String? selectedType;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AddNewActivityCubit>(),
      child: BlocConsumer<AddNewActivityCubit, AddNewActivityState>(
        listener: (context, state) {
          if (state is AddNewActivitySuccess) {
            primarySnackBar(
              context,
              "تم إضافة النشاط بنجاح",
              icon: Icons.check_circle_outline,
              boxColor: AppColors.greenColor,
            );
            GoRouter.of(context).pop();
            context.read<ActivitesCubit>().getActivites();
          } else if (state is AddNewActivityFailure) {
            primarySnackBar(
              context,
              state.failure.message,
              icon: Icons.error_outline,
              boxColor: AppColors.redColor,
            );
          }
        },
        builder: (context, state) {
          return Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// صورة النشاط
                Center(
                  child: ImagePickerWidget(
                    onImageSelected: (File? image) {
                      setState(() => selectedImage = image);
                    },
                  ),
                ),
                // const VerticalSpace(8),

                /// اسم النشاط
                UnderLineInputBorderTextFormField(
                  controller: categoryNameController,
                  type: TextInputType.name,
                  hintText: 'اسم النشاط',
                ),
                const VerticalSpace(24),

                /// الوصف
                OutLineInputBorderTextFormField(
                  controller: descriptionController,
                  hintText: 'الوصف',
                  type: TextInputType.multiline,
                  minLines: 4,
                ),
                const VerticalSpace(24),

                /// أسعار الاشتراك
                Text(
                  "قيمة الاشتراك",
                  style: AppStyles.styleBold14(
                    context,
                  ).copyWith(color: AppColors.pureBlackColor),
                ),
                const VerticalSpace(4),
                Row(
                  children: [
                    Expanded(
                      child: Transform.scale(
                        scaleY: 0.85,
                        child: OutLineInputBorderTextFormField(
                          controller: memberPriceController,
                          hintText: 'للأعضاء',
                          type: TextInputType.number,
                          textStyle: AppStyles.styleBold18(
                            context,
                          ).copyWith(color: AppColors.blueColor),
                        ),
                      ),
                    ),
                    const HorizontalSpace(12),
                    Expanded(
                      child: Transform.scale(
                        scaleY: 0.85,
                        child: OutLineInputBorderTextFormField(
                          controller: guestPriceController,
                          hintText: 'لغير الأعضاء',
                          type: TextInputType.number,
                          textStyle: AppStyles.styleBold18(
                            context,
                          ).copyWith(color: AppColors.blueColor),
                        ),
                      ),
                    ),
                  ],
                ),
                const VerticalSpace(16),

                /// نوع النشاط (Dropdown)
                // Text("نوع النشاط", style: AppStyles.styleBold14(context).copyWith(color: AppColors.pureBlackColor)),
                const VerticalSpace(8),
                DropdownWidget(
                  value: selectedType,
                  hintText: "تصنيف النشاط",
                  items:
                      AppConstants.activityTypes
                          .map(
                            (type) => DropdownMenuItem<String>(
                              value: type,
                              child: Text(
                                type,
                                style: AppStyles.styleSemiBold16(
                                  context,
                                ).copyWith(color: AppColors.greenColor),
                              ),
                            ),
                          )
                          .toList(),
                  onChanged: (val) => setState(() => selectedType = val),
                ),

                const VerticalSpace(48),

                /// زر الحفظ
                state is AddNewActivityLoading
                    ? PrimaryButton(
                      onPressed: () {},
                      child: PrimaryCircularProgressIndicator(
                        color: AppColors.pureWhiteColor,
                      ),
                    )
                    : PrimaryButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();

                        // if (selectedImage == null) {
                        //   primarySnackBar(
                        //     context,
                        //     'يجب تحديد صورة',
                        //     icon: Iconsax.danger,
                        //     iconSize: 32,
                        //     iconColor: Colors.yellow,
                        //     boxColor: AppColors.pureBlackColor,
                        //   );
                        //   return;
                        // }

                        if (formKey.currentState!.validate()) {
                          context.read<AddNewActivityCubit>().addNewActivity(
                            requestModel: AddNewActivityRequestModel(
                              title: categoryNameController.text.trim(),
                              description: descriptionController.text.trim(),
                              money: guestPriceController.text.trim(),
                              moneyMember: memberPriceController.text.trim(),
                              type: selectedType ?? "",
                            ),
                            image: selectedImage,
                          );
                        }
                      },
                      text: AppStrings.save.tr(),
                    ),
              ],
            ),
          );
        },
      ),
    );
  }
}
