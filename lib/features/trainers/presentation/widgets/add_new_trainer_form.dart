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
    "الاثنين",
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
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          backgroundColor: AppColors.pureWhiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: StatefulBuilder(
            builder: (context, setState) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 24,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    VerticalSpace(24),

                    Text(
                      "إضافة موعد جديد",
                      style: AppStyles.styleBold24(
                        context,
                      ).copyWith(color: AppColors.primaryColor),
                    ),
                    const VerticalSpace(24),

                    /// اليوم
                    Transform.scale(
                      scaleY: 0.95,
                      child: DropdownWidget(
                        value: selectedDay,
                        items:
                            days
                                .map(
                                  (day) => DropdownMenuItem(
                                    value: day,
                                    child: Text(
                                      day,
                                      style: AppStyles.styleBold18(
                                        context,
                                      ).copyWith(
                                        color: AppColors.lightBlackColor,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                        onChanged: (val) => setState(() => selectedDay = val),
                        hintText: "اختر اليوم",
                      ),
                    ),
                    const VerticalSpace(16),

                    /// وقت البداية والنهاية
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
                                        backgroundColor:
                                            AppColors.pureWhiteColor,
                                        hourMinuteTextStyle:
                                            AppStyles.styleBold24(
                                              context,
                                            ).copyWith(
                                              color: AppColors.primaryColor,
                                            ),
                                        dayPeriodTextStyle:
                                            AppStyles.styleMedium16(
                                              context,
                                            ).copyWith(
                                              color: AppColors.primaryColor,
                                            ),
                                        dialHandColor: AppColors.primaryColor,
                                        dialBackgroundColor:
                                            AppColors.lightGreyColor,
                                      ),
                                      colorScheme: ColorScheme.light(
                                        primary: AppColors.primaryColor,
                                        onPrimary: AppColors.pureWhiteColor,
                                        onSurface: AppColors.greyColor,
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
                                        backgroundColor:
                                            AppColors.pureWhiteColor,
                                        hourMinuteTextStyle:
                                            AppStyles.styleBold24(
                                              context,
                                            ).copyWith(
                                              color: AppColors.primaryColor,
                                            ),
                                        dialHandColor: AppColors.primaryColor,
                                        dialBackgroundColor:
                                            AppColors.lightGreyColor,
                                      ),
                                      colorScheme: ColorScheme.light(
                                        primary: AppColors.primaryColor,
                                        onPrimary: AppColors.pureWhiteColor,
                                        onSurface: AppColors.greyColor,
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

                    const VerticalSpace(64),

                    /// الأزرار
                    Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: ActionButton(
                            text: "إلغاء",
                            borderColor: AppColors.greyColor,
                            backgroundColor: AppColors.pureWhiteColor,
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                        const HorizontalSpace(12),
                        Expanded(
                          flex: 5,
                          child: ActionButton(
                            text: "إضافة",
                            textColor: AppColors.pureWhiteColor,
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
                              } else {
                                primarySnackBar(
                                  context,
                                  "الرجاء اختيار اليوم ووقت البداية والنهاية",
                                  icon: Icons.warning_amber_rounded,
                                  boxColor: Colors.orange,
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    VerticalSpace(32),
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

                /// زرار إضافة موعد
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
                const VerticalSpace(8),

                /// عرض المواعيد المضافة
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: trainerTimes.length,
                  itemBuilder: (context, index) {
                    final t = trainerTimes[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: AppColors.lightGreyColor),
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
                const VerticalSpace(48),
              ],
            ),
          );
        },
      ),
    );
  }
}
