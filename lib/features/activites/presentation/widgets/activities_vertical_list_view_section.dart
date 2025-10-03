import 'package:fayoum_club_management/core/utils/app_colors.dart';
import 'package:fayoum_club_management/core/utils/app_strings.dart';
import 'package:fayoum_club_management/core/functions/dummy_lists.dart';
import 'package:fayoum_club_management/core/widgets/app_indicators.dart';
import 'package:fayoum_club_management/core/widgets/retry_widget.dart';
import 'package:fayoum_club_management/features/activites/presentation/manager/activites_cubit/activites_cubit.dart';
import 'package:fayoum_club_management/features/activites/presentation/manager/activites_cubit/activites_state.dart';
import 'package:fayoum_club_management/features/activites/presentation/widgets/activites_vertical_list_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ActivitiesVerticalListViewSection extends StatelessWidget {
  const ActivitiesVerticalListViewSection({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimaryRefreshIndicator(
      onRefresh: () async {
        context.read<ActivitesCubit>().getActivites();
      },
      child: BlocBuilder<ActivitesCubit, ActivitesState>(
        builder: (context, state) {
          if (state is ActivitesLoading) {
            return Skeletonizer(
              containersColor: AppColors.loadingEffectColor,
              textBoneBorderRadius: TextBoneBorderRadius(BorderRadius.circular(4)),
              child: ActivitesListView(activites: getDummyActivitiesList()),
            );
          } else if (state is ActivitesSuccess) {
            return ActivitesListView(
              activites: state.activitesModel.data,
            );
          } else if (state is ActivitesFailure) {
            return RetryWidget(
              message: state.failure.errMessage,
              onPressed: () {
                context.read<ActivitesCubit>().getActivites();
              },
            );
          } else {
            return RetryWidget(
              message: AppStrings.unexpectedError.tr(),
              onPressed: () {
                context.read<ActivitesCubit>().getActivites();
              },
            );
          }
        },
      ),
    );
  }
}
