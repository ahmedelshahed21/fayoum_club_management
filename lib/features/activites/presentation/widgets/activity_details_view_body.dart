import 'package:cached_network_image/cached_network_image.dart';
import 'package:fayoum_club_management/core/utils/app_colors.dart';
import 'package:fayoum_club_management/core/utils/app_constants.dart';
import 'package:fayoum_club_management/core/utils/app_styles.dart';
import 'package:fayoum_club_management/core/routes/app_router.dart';
import 'package:fayoum_club_management/core/services/service_locator.dart';
import 'package:fayoum_club_management/core/widgets/app_buttons.dart';
import 'package:fayoum_club_management/core/widgets/back_icon_button.dart';
import 'package:fayoum_club_management/core/widgets/image_loading_effect.dart';
import 'package:fayoum_club_management/core/widgets/spacing.dart';
import 'package:fayoum_club_management/features/activites/data/models/activity_details_model/activity_details_model.dart';
import 'package:fayoum_club_management/features/activites/presentation/manager/delete_activity_cubit/delete_activity_cubit.dart';
import 'package:fayoum_club_management/features/activites/presentation/widgets/delete_activity_dialog.dart';
import 'package:fayoum_club_management/features/activites/presentation/widgets/subscription_section.dart';
import 'package:fayoum_club_management/features/activites/presentation/widgets/trainers_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ActivityDetailsViewBody extends StatelessWidget {
  const ActivityDetailsViewBody({super.key, required this.detailsData});

  final ActivityDetailsData detailsData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              /// SliverAppBar لعرض صورة النشاط
              SliverAppBar(
                expandedHeight: 220,
                pinned: true,
                centerTitle: true,
                title: Text(
                  detailsData.title,
                  style: AppStyles.styleSemiBold18(
                    context,
                  ).copyWith(color: AppColors.pureWhiteColor),
                ),
                backgroundColor: AppColors.primaryColor,
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: BackIconButton(),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: CachedNetworkImage(
                    imageUrl: detailsData.image ?? AppConstants.noImageUrl,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const ImageLoadingEffect(),
                    errorWidget:
                        (context, url, error) => Container(
                          color: Colors.grey.shade300,
                          width: double.infinity,
                          height: 220,
                          child: const Icon(Icons.broken_image, size: 40),
                        ),
                  ),
                ),
              ),

              /// باقي المحتوى
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const VerticalSpace(8),
                      Text(
                        detailsData.description ?? '',
                        style: AppStyles.styleRegular16(context),
                      ),
                      const VerticalSpace(24),
                      SubscriptionSection(detailsData: detailsData),
                      const VerticalSpace(24),
                      TrainersSection(detailsData: detailsData),
                      const VerticalSpace(80),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        /// bottomNavigationBar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Expanded(
                child: PrimaryButton(
                  backgroundColor: AppColors.redColor,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (builder) {
                        return BlocProvider(
                          create: (_) => getIt<DeleteActivityCubit>(),
                          child: DeleteActivityDialog(id: detailsData.id),
                        );
                      },
                    );
                  },
                  text: 'حذف النشاط',
                ),
              ),
              HorizontalSpace(12),
              Expanded(
                child: PrimaryButton(
                  backgroundColor: AppColors.greenColor,
                  onPressed: () {
                    GoRouter.of(
                      context,
                    ).push(AppRouter.addNewTrainerView, extra: detailsData.id);
                  },
                  text: 'إضافة مدرب',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
