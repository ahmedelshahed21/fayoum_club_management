import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:fayoum_club_management/core/utils/app_colors.dart';
import 'package:fayoum_club_management/core/utils/app_strings.dart';
import 'package:fayoum_club_management/core/functions/app_snack_bars.dart';
import 'package:fayoum_club_management/core/services/service_locator.dart';
import 'package:fayoum_club_management/core/utils/app_styles.dart';
import 'package:fayoum_club_management/core/widgets/app_buttons.dart';
import 'package:fayoum_club_management/core/widgets/app_indicators.dart';
import 'package:fayoum_club_management/core/widgets/app_text_fields.dart';
import 'package:fayoum_club_management/core/widgets/dropdown_widget.dart';
import 'package:fayoum_club_management/core/widgets/spacing.dart';
import 'package:fayoum_club_management/core/widgets/image_picker_widget.dart';
import 'package:fayoum_club_management/features/activites/presentation/manager/activity_details_cubit/activity_details_cubit.dart';
import 'package:fayoum_club_management/features/trainers/data/models/add_new_trainer_request_model.dart';
import 'package:fayoum_club_management/features/trainers/presentation/manager/add_new_trainer_cubit/add_new_trainer_cubit.dart';
import 'package:fayoum_club_management/features/trainers/presentation/manager/add_new_trainer_cubit/add_new_trainer_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

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
  final List<String> days = [
    "السبت",
    "الأحد",
    "الإثنين",
    "الثلاثاء",
    "الأربعاء",
    "الخميس",
    "الجمعة",
  ];

  List<TrainerTime> trainerTimes = [];


  Future<void> showAddTimeDialog(BuildContext context) async {
    String? selectedDay;
    TimeOfDay? fromTime;
    TimeOfDay? toTime;

    await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: AppColors.pureWhiteColor,
          child: StatefulBuilder(
            builder: (context, setState) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const VerticalSpace(48),
                    Text(
                      "إضافة موعد جديد",
                      style: AppStyles.styleBold24(
                        context,
                      ).copyWith(color: AppColors.primaryColor),
                    ),
                    const VerticalSpace(32),

                    Transform.scale(
                      scaleY:0.9 ,
                      child: DropdownWidget(
                        value: selectedDay,
                        items:
                            days.map(
                                  (day) => DropdownMenuItem(
                                    value: day,
                                    child: Text(
                                      day,
                                      style: AppStyles.styleBold18(
                                        context,
                                      ), // 🎨 ستايل من AppStyles
                                    ),
                                  ),
                                )
                                .toList(),
                        onChanged: (val) => setState(() => selectedDay = val),
                        hintText: "اختر اليوم",
                      ),
                    ),

                    const VerticalSpace(16),

                    /// وقت البداية + النهاية جنب بعض
                    Row(
                      children: [
                        Expanded(
                          child: SecondaryButton(
                            borderColor: AppColors.lightGreyColor,
                            text:
                                fromTime == null
                                    ? "وقت البداية"
                                    : "من: ${fromTime!.format(context)}",
                            onPressed: () async {
                              final picked = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                                builder: (context, child) {
                                  return Theme(
                                    data: Theme.of(context).copyWith(
                                      timePickerTheme: TimePickerThemeData(
                                        backgroundColor: AppColors.pureWhiteColor, // خلفية البوكس
                                        hourMinuteTextStyle: AppStyles.styleBold24(context).copyWith(
                                          color: AppColors.primaryColor,
                                        ), // النص الأساسي للوقت
                                        dayPeriodTextStyle: AppStyles.styleMedium16(context).copyWith(
                                          color: AppColors.primaryColor,
                                        ),
                                        dialHandColor: AppColors.primaryColor, // لون مؤشر الساعة
                                        dialBackgroundColor: AppColors.lightGreyColor.withOpacity(0.2),
                                        entryModeIconColor: AppColors.primaryColor,
                                        hourMinuteColor: MaterialStateColor.resolveWith((states) {
                                          if (states.contains(MaterialState.selected)) {
                                            return AppColors.primaryColor;
                                          }
                                          return AppColors.lightGreyColor;
                                        }),
                                      ),
                                      colorScheme: ColorScheme.light(
                                        primary: AppColors.primaryColor, // اللون الأساسي للأزرار
                                        onPrimary: AppColors.pureWhiteColor, // لون النص فوق الزر الأساسي
                                        onSurface: AppColors.greyColor, // لون النصوص العادية
                                      ),
                                      textTheme: Theme.of(context).textTheme.copyWith(
                                        bodyLarge: AppStyles.styleRegular16(context),
                                        bodyMedium: AppStyles.styleRegular14(context),
                                        titleMedium: AppStyles.styleBold18(context),
                                      ),
                                    ),
                                    child: child!,
                                  );
                                },
                              );

                              if (picked != null) {
                                setState(() => fromTime = picked);
                              }
                            },
                          ),
                        ),
                        const HorizontalSpace(12),
                        Expanded(
                          child: SecondaryButton(
                            borderColor: AppColors.lightGreyColor,
                            text:
                                toTime == null
                                    ? "وقت النهاية"
                                    : "إلى: ${toTime!.format(context)}",
                            onPressed: () async {
                              final picked = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                                builder: (context, child) {
                                  return Theme(
                                    data: Theme.of(context).copyWith(
                                      timePickerTheme: TimePickerThemeData(
                                        backgroundColor: AppColors.pureWhiteColor, // خلفية البوكس
                                        hourMinuteTextStyle: AppStyles.styleBold24(context).copyWith(
                                          color: AppColors.primaryColor,
                                        ), // النص الأساسي للوقت
                                        dayPeriodTextStyle: AppStyles.styleBold24(context).copyWith(
                                          color: AppColors.primaryColor,
                                        ),
                                        dialHandColor: AppColors.primaryColor, // لون مؤشر الساعة
                                        dialBackgroundColor: AppColors.lightGreyColor.withOpacity(0.2),
                                        entryModeIconColor: AppColors.primaryColor,
                                        hourMinuteColor: MaterialStateColor.resolveWith((states) {
                                          if (states.contains(MaterialState.selected)) {
                                            return AppColors.primaryColor;
                                          }
                                          return AppColors.lightGreyColor;
                                        }),
                                      ),
                                      colorScheme: ColorScheme.light(
                                        primary: AppColors.primaryColor, // اللون الأساسي للأزرار
                                        onPrimary: AppColors.pureWhiteColor, // لون النص فوق الزر الأساسي
                                        onSurface: AppColors.greyColor, // لون النصوص العادية
                                      ),
                                      textTheme: Theme.of(context).textTheme.copyWith(
                                        bodyLarge: AppStyles.styleSemiBold16(context),
                                        bodyMedium: AppStyles.styleMedium16(context),
                                        titleMedium: AppStyles.styleBold18(context),
                                        bodySmall: AppStyles.styleRegular14(context),
                                      ),
                                    ),
                                    child: child!,
                                  );
                                },
                              );

                              if (picked != null) {
                                setState(() => toTime = picked);
                              }
                            },
                          ),
                        ),
                      ],
                    ),

                    const VerticalSpace(48),

                    /// الأزرار (إلغاء / إضافة)
                    PrimaryButton(
                      text: "إضافة",
                      onPressed: () {
                        if (selectedDay != null &&
                            fromTime != null &&
                            toTime != null) {
                          final newTime = TrainerTime(
                            day: selectedDay!,
                            fromTime:
                                "${fromTime!.hour.toString().padLeft(2, '0')}:${fromTime!.minute.toString().padLeft(2, '0')}",
                            toTime:
                                "${toTime!.hour.toString().padLeft(2, '0')}:${toTime!.minute.toString().padLeft(2, '0')}",
                          );
                          Navigator.pop(context, newTime);
                        }
                      },
                    ),
                    const VerticalSpace(48),
                  ],
                ),
              );
            },
          ),
        );
      },
    ).then((result) {
      if (result != null && result is TrainerTime) {
        setState(() => trainerTimes.add(result));
      }
    });
  }

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
            context.read<ActivityDetailsCubit>().getActivityDetails(
              activityId: widget.activityId,
            );
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

                // ✅ زرار لإضافة موعد
                ActionButton(
                  backgroundColor: AppColors.pureWhiteColor,
                  textColor: AppColors.primaryColor,
                  borderColor: AppColors.primaryColor,
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    showAddTimeDialog(context);
                  },
                  text: "إضافة موعد",
                ),

                // ElevatedButton.icon(
                //   onPressed: () => _showAddTimeDialog(context),
                //   icon: const Icon(Icons.add),
                //   label: const Text("إضافة موعد"),
                // ),
                const VerticalSpace(4),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: trainerTimes.length,
                  itemBuilder: (context, index) {
                    final t = trainerTimes[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: AppColors.lightGreyColor
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                      color: AppColors.pureWhiteColor,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      child: ListTile(
                        title: Text(
                          "${t.day} - ${t.fromTime} : ${t.toTime}",
                          style: AppStyles.styleMedium16(context),
                        ),
                        trailing: IconButton(
                          icon: Icon(Iconsax.trash, color: AppColors.redColor),
                          onPressed: () {
                            setState(() => trainerTimes.removeAt(index));
                          },
                        ),
                      ),
                    );
                  },
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

                        final requestModel = AddNewTrainerRequestModel(
                          name: nameController.text.trim(),
                          description: descriptionController.text.trim(),
                          isActive: isActive ? 1 : 0,
                          activityId: widget.activityId,
                          times: trainerTimes,
                        );

                        context.read<AddNewTrainerCubit>().addNewTrainer(
                          requestModel: requestModel,
                          image: selectedImage,
                        );
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
