import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:fayoum_club_management/core/utils/app_colors.dart';
import 'package:fayoum_club_management/core/utils/app_styles.dart';
import 'package:fayoum_club_management/core/widgets/dropdown_widget.dart';
import 'package:fayoum_club_management/features/activites/presentation/manager/activites_cubit/activites_cubit.dart';
import 'package:fayoum_club_management/features/activites/presentation/manager/activites_cubit/activites_state.dart';

class ActivitiesDropdownWidget extends StatelessWidget {
  final String? selectedValue;
  final ValueChanged<String?> onChanged;

  const ActivitiesDropdownWidget({
    super.key,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActivitesCubit, ActivitesState>(
      builder: (context, state) {
        if (state is ActivitesLoading) {
          return Skeletonizer(
            child: DropdownWidget(
              value: null,
              items: const [],
              onChanged: (_) {},
              hintText: "تحميل الأنشطة...",
            ),
          );
        } else if (state is ActivitesSuccess) {
          final items =
              state.activitesModel.data
                  .map(
                    (activity) => DropdownMenuItem<String>(
                      value: activity.id.toString(),
                      child: Text(
                        activity.title ?? "",
                        style: AppStyles.styleBold14(
                          context,
                        ).copyWith(color: AppColors.primaryColor),
                      ),
                    ),
                  )
                  .toList();
          final validValue =
              items.any((i) => i.value == selectedValue) ? selectedValue : null;
          return DropdownWidget(
            value: validValue,
            hintText: "اختر النشاط",
            items: items,
            onChanged: onChanged,
          );
        } else if (state is ActivitesFailure) {
          return Text(
            "فشل تحميل الأنشطة",
            style: const TextStyle(color: Colors.red),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
