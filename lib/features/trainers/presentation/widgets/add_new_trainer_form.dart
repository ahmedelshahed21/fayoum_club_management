import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:fayoum_club_management/core/utils/app_colors.dart';
import 'package:fayoum_club_management/core/utils/app_strings.dart';
import 'package:fayoum_club_management/core/utils/app_styles.dart';
import 'package:fayoum_club_management/core/functions/app_snack_bars.dart';
import 'package:fayoum_club_management/core/services/service_locator.dart';
import 'package:fayoum_club_management/core/widgets/app_buttons.dart';
import 'package:fayoum_club_management/core/widgets/app_indicators.dart';
import 'package:fayoum_club_management/core/widgets/app_text_fields.dart';
import 'package:fayoum_club_management/core/widgets/spacing.dart';
import 'package:fayoum_club_management/core/widgets/image_picker_widget.dart';
import 'package:fayoum_club_management/features/trainers/data/models/add_new_trainer_request_model.dart';
import 'package:fayoum_club_management/features/trainers/presentation/manager/add_new_trainer_cubit/add_new_trainer_cubit.dart';
import 'package:fayoum_club_management/features/trainers/presentation/manager/add_new_trainer_cubit/add_new_trainer_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewTrainerForm extends StatefulWidget {
  const AddNewTrainerForm({super.key, required this.activityId});
  final int activityId;

  @override
  State<AddNewTrainerForm> createState() => _AddNewTrainerFormState();
}

class _AddNewTrainerFormState extends State<AddNewTrainerForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  File? selectedImage;
  bool isActive = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AddNewTrainerCubit>(),
      child: BlocConsumer<AddNewTrainerCubit, AddNewTrainerState>(
        listener: (context, state) {
          if (state is AddNewTrainerSuccess) {
            primarySnackBar(
              context,
              state.model.message ?? "تم إضافة المدرب بنجاح",
              icon: Icons.check_circle_outline,
              boxColor: AppColors.greenColor,
            );
            Navigator.pop(context);
            // يمكنك هنا تحديث قائمة المدربين إذا كان لديك Cubit خاص بهم
          } else if (state is AddNewTrainerFailure) {
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
                Center(
                  child: ImagePickerWidget(
                    onImageSelected: (File? image) {
                      setState(() => selectedImage = image);
                    },
                  ),
                ),
                UnderLineInputBorderTextFormField(
                  controller: nameController,
                  type: TextInputType.name,
                  hintText: 'اسم المدرب',
                ),
                const VerticalSpace(24),
                OutLineInputBorderTextFormField(
                  controller: descriptionController,
                  hintText: 'نبذة عن المدرب',
                  type: TextInputType.multiline,
                  minLines: 5,
                ),
                const VerticalSpace(16),
                Row(
                  children: [
                    Checkbox(
                      activeColor: AppColors.primaryColor,
                      value: isActive,
                      onChanged:
                          (val) => setState(() => isActive = val ?? true),
                    ),
                    Text("نشط", style: AppStyles.styleSemiBold18(context)),
                  ],
                ),
                const VerticalSpace(32),
                state is AddNewTrainerLoading
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
                        //     icon: Icons.error_outline,
                        //     iconColor: Colors.yellow,
                        //     boxColor: AppColors.pureBlackColor,
                        //   );
                        //   return;
                        // }

                        if (formKey.currentState!.validate()) {
                          final requestModel = AddNewTrainerRequestModel(
                            name: nameController.text.trim(),
                            description: descriptionController.text.trim(),
                            isActive: isActive ? 1 : 0,
                            activityId: widget.activityId,
                          );

                          context.read<AddNewTrainerCubit>().addNewTrainer(
                            requestModel: requestModel,
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
