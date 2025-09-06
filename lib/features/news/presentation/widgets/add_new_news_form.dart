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
import 'package:fayoum_club_management/features/home/presentation/manager/banners_cubit/banners_cubit.dart';
import 'package:fayoum_club_management/features/news/data/models/add_new_news_request_model/add_new_news_request_model.dart';
import 'package:fayoum_club_management/features/news/presentation/manager/add_new_news_cubit/add_new_news_cubit.dart';
import 'package:fayoum_club_management/features/news/presentation/manager/add_new_news_cubit/add_new_news_state.dart';
import 'package:fayoum_club_management/features/news/presentation/manager/news_cubit/news_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewNewsForm extends StatefulWidget {
  const AddNewNewsForm({super.key});

  @override
  State<AddNewNewsForm> createState() => _AddNewNewsFormState();
}

class _AddNewNewsFormState extends State<AddNewNewsForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  File? selectedImage;
  bool isUrgent = false;
  String? newsType;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AddNewNewsCubit>(),
      child: BlocConsumer<AddNewNewsCubit, AddNewNewsState>(
        listener: (context, state) {
          if (state is AddNewNewsSuccess) {
            primarySnackBar(
              context,
              state.model.message ?? "تم إضافة الخبر بنجاح",
              icon: Icons.check_circle_outline,
              boxColor: AppColors.greenColor,
            );
            // Navigator.pop(context);
            context.read<NewsCubit>().fetchNews(refresh: true);
            context.read<BannersCubit>().getBanners();
          } else if (state is AddNewNewsFailure) {
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
                  controller: titleController,
                  type: TextInputType.name,
                  hintText: 'عنوان الخبر',
                ),
                const VerticalSpace(24),
                OutLineInputBorderTextFormField(
                  controller: descriptionController,
                  hintText: 'تفاصيل الخبر',
                  type: TextInputType.multiline,
                  minLines: 5,
                ),
                const VerticalSpace(16),
                Text("نوع الخبر", style: AppStyles.styleBold14(context)),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile<String>(
                        activeColor: AppColors.primaryColor,
                        title: Text(
                          "ممارسة",
                          style: AppStyles.styleSemiBold14(context),
                        ),
                        value: "practice",
                        groupValue: newsType,
                        onChanged: (val) => setState(() => newsType = val),
                      ),
                    ),
                    const HorizontalSpace(4),
                    Expanded(
                      child: RadioListTile<String>(
                        activeColor: AppColors.primaryColor,
                        title: Text(
                          "منافسة",
                          style: AppStyles.styleSemiBold14(context),
                        ),
                        value: "competition",
                        groupValue: newsType,
                        onChanged: (val) => setState(() => newsType = val),
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
                      value: isUrgent,
                      onChanged:
                          (val) => setState(() => isUrgent = val ?? false),
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
                state is AddNewNewsLoading
                    ? PrimaryButton(
                      onPressed: () {},
                      child: PrimaryCircularProgressIndicator(
                        color: AppColors.pureWhiteColor,
                      ),
                    )
                    : PrimaryButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();

                        final requestModel = AddNewNewsRequestModel(
                          title: titleController.text.trim(),
                          description: descriptionController.text.trim(),
                          activityId: "8",
                          status: isUrgent ? 1 : 0,
                          typeOption: newsType,
                        );

                        context.read<AddNewNewsCubit>().addNewNews(
                          requestModel: requestModel,
                          image: selectedImage,
                        );
                        // }
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
