import 'package:cached_network_image/cached_network_image.dart';
import 'package:fayoum_club_management/core/utils/app_colors.dart';
import 'package:fayoum_club_management/core/utils/app_constants.dart';
import 'package:fayoum_club_management/core/utils/app_styles.dart';
import 'package:fayoum_club_management/core/services/service_locator.dart';
import 'package:fayoum_club_management/core/widgets/app_app_bars.dart';
import 'package:fayoum_club_management/core/widgets/app_buttons.dart';
import 'package:fayoum_club_management/core/widgets/image_loading_effect.dart';
import 'package:fayoum_club_management/core/widgets/spacing.dart';
import 'package:fayoum_club_management/features/activites/data/models/activity_details_model/activity_details_model.dart';
import 'package:fayoum_club_management/features/trainers/presentation/manager/delete_trainer_cubit/delete_trainer_cubit.dart';
import 'package:fayoum_club_management/features/trainers/presentation/widgets/delete_trainer_dialog.dart';
import 'package:fayoum_club_management/features/trainers/presentation/widgets/trainer_time_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class TrainerView extends StatelessWidget {
  const TrainerView({super.key, required this.trainer});

  final CaptainModel trainer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhiteColor,
      appBar: PrimaryAppBar(title: "المدرب"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    VerticalSpace(16),
                    Column(
                      children: [
                        Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(64),
                            child: CachedNetworkImage(
                              imageUrl:
                                  trainer.image ?? AppConstants.noImageUrl,
                              width: 120,
                              height: 120,
                              fit: BoxFit.cover,
                              placeholder:
                                  (context, url) => const ImageLoadingEffect(),
                              errorWidget:
                                  (context, url, error) => Container(
                                    width: 150,
                                    height: 150,
                                    color: AppColors.pureWhiteColor,
                                    child: Icon(
                                      Iconsax.user_copy,
                                      color: AppColors.greenColor,
                                      size: 60,
                                    ),
                                  ),
                            ),
                          ),
                        ),
                        VerticalSpace(16),
                        Text(
                          trainer.name,
                          style: AppStyles.styleBold20(
                            context,
                          ).copyWith(color: AppColors.primaryColor),
                        ),
                      ],
                    ),
                    VerticalSpace(32),
                    if (trainer.description != null &&
                        trainer.description!.isNotEmpty)
                      Text(
                        trainer.description!,
                        style: AppStyles.styleRegular14(
                          context,
                        ).copyWith(color: AppColors.greyColor),
                        textAlign: TextAlign.center,
                      ),
                    VerticalSpace(32),
                    TrainerTimeSection(trainer: trainer),

                  ],
                ),
              ),
            ),


            SafeArea(
              minimum: const EdgeInsets.symmetric(vertical: 16),
              child: PrimaryButton(
                backgroundColor: AppColors.redColor,
                text: 'حذف المدرب',
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (builder) {
                      return BlocProvider(
                        create: (_) => getIt<DeleteTrainerCubit>(),
                        child: DeleteTrainerDialog(id: trainer.id),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
