import 'package:fayoum_club_management/core/services/service_locator.dart';
import 'package:fayoum_club_management/core/utils/app_colors.dart';
import 'package:fayoum_club_management/core/utils/app_styles.dart';
import 'package:fayoum_club_management/core/widgets/spacing.dart';
import 'package:fayoum_club_management/features/activites/presentation/manager/activites_cubit/activites_cubit.dart';
import 'package:fayoum_club_management/features/activites/presentation/widgets/activities_vertical_list_view_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActivitiesView extends StatefulWidget {
  const ActivitiesView({super.key});

  @override
  State<ActivitiesView> createState() => _ActivitiesViewState();
}

class _ActivitiesViewState extends State<ActivitiesView> {
  final List<String> tabs = [
    "الكل",
    "ألعاب فردية ومنازلات",
    "ألعاب جماعية",
    "ألعاب المضرب",
    "لياقة بدنية",
    "رياضات مائية",
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Column(
        children: [
          Container(
            color: AppColors.offWhiteColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const VerticalSpace(12),
                Text(
                  "الأنشطة",
                  style: AppStyles.styleBold18(context)
                      .copyWith(color: AppColors.pureBlackColor),
                ),
                TabBar(
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  indicatorColor: AppColors.greenColor,
                  labelColor: AppColors.greenColor,
                  unselectedLabelColor: AppColors.pureBlackColor,
                  splashBorderRadius: BorderRadius.circular(8),
                  dividerHeight: 0,
                  labelStyle: AppStyles.styleBold14(context),
                  unselectedLabelStyle: AppStyles.styleSemiBold12(context),
                  tabs: tabs
                      .map(
                        (title) => Tab(
                      child: FittedBox(
                        child: Text(
                          title,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                        ),
                      ),
                    ),
                  )
                      .toList(),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: tabs.map((type) {
                final String? selectedType = type == "الكل" ? null : type;
                return BlocProvider(
                  create: (context) =>
                  getIt<ActivitesCubit>()..getActivites(type: selectedType),
                  child: ActivitiesVerticalListViewSection(type: selectedType),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
