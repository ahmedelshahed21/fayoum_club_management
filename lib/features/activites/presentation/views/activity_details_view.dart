import 'package:fayoum_club_management/core/functions/dummy_lists.dart';
import 'package:fayoum_club_management/features/activites/presentation/manager/activity_details_cubit/activity_details_cubit.dart';
import 'package:fayoum_club_management/features/activites/presentation/manager/activity_details_cubit/activity_details_state.dart';
import 'package:fayoum_club_management/features/activites/presentation/widgets/activity_details_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fayoum_club_management/core/utils/app_colors.dart';
import 'package:fayoum_club_management/core/services/service_locator.dart';
import 'package:fayoum_club_management/core/widgets/retry_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ActivityDetailsView extends StatelessWidget {
  const ActivityDetailsView({super.key, required this.activityId});

  final int activityId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pureWhiteColor,
      body: BlocProvider(
        create:
            (context) =>
                getIt<ActivityDetailsCubit>()..getActivityDetails(activityId: activityId),
        child: BlocBuilder<ActivityDetailsCubit, ActivityDetailsState>(
          builder: (context, state) {
            if (state is ActivityDetailsLoading) {
              return Skeletonizer(
                containersColor: AppColors.loadingEffectColor,
                textBoneBorderRadius: TextBoneBorderRadius(
                  BorderRadius.circular(4),
                ),
                child: ActivityDetailsViewBody(
                  activityDetailsData: getDummyActivityDetails(), // dummy
                ),
              );
            } else if (state is ActivityDetailsSuccess) {
              return ActivityDetailsViewBody(
                activityDetailsData: state.activityDetailsModel.data!,
              );
            } else if (state is ActivityDetailsFailure) {
              return RetryWidget(
                message: state.failure.errMessage,
                onPressed:
                    () => context
                        .read<ActivityDetailsCubit>()
                        .getActivityDetails(activityId: activityId),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
