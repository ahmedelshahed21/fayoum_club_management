import 'package:cached_network_image/cached_network_image.dart';
import 'package:fayoum_club_management/core/utils/app_colors.dart';
import 'package:fayoum_club_management/core/utils/app_constants.dart';
import 'package:fayoum_club_management/core/utils/app_styles.dart';
import 'package:fayoum_club_management/core/functions/run_if_connected.dart';
import 'package:fayoum_club_management/core/routes/app_router.dart';
import 'package:fayoum_club_management/core/services/service_locator.dart';
import 'package:fayoum_club_management/core/widgets/image_loading_effect.dart';
import 'package:fayoum_club_management/features/activites/presentation/manager/delete_activity_cubit/delete_activity_cubit.dart';
import 'package:fayoum_club_management/features/activites/presentation/widgets/delete_activity_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:fayoum_club_management/features/activites/data/models/activites_model/activites_model.dart';

class ActivityCard extends StatelessWidget {
  final ActivityItem activityItem;

  const ActivityCard({super.key, required this.activityItem});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap:
          () => runIfConnected(
            context: context,
            onConnected: () {
              showDialog(
                context: context,
                builder: (builder) {
                  return BlocProvider(
                    create: (_) => getIt<DeleteActivityCubit>(),
                    child: DeleteActivityDialog(id: activityItem.id!),
                  );
                },
              );
            },
          ),
      onTap:
          () => runIfConnected(
            context: context,
            onConnected: () {
              GoRouter.of(
                context,
              ).push(AppRouter.activityDetailsView, extra: activityItem.id);
            },
          ),
      child: AspectRatio(
        aspectRatio: 8 / 5,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColors.pureWhiteColor,
            boxShadow: [
              BoxShadow(
                color: AppColors.lightGreyColor,
                spreadRadius: 2,
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Stack(
              fit: StackFit.expand,
              children: [
                CachedNetworkImage(
                  imageUrl: activityItem.image ?? AppConstants.noImageUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const ImageLoadingEffect(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: AppColors.offWhiteColor.withValues(alpha: 0.9),
                    ),
                    child: FittedBox(
                      child: Text(
                        activityItem.title ?? '',
                        style: AppStyles.styleExtraBold20(
                          context,
                        ).copyWith(color: AppColors.primaryColor),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
