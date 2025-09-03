import 'package:easy_localization/easy_localization.dart';
import 'package:fayoum_club_management/core/widgets/confirmation_dialog_with_horizontal_buttons.dart';
import 'package:fayoum_club_management/features/activites/presentation/manager/activites_cubit/activites_cubit.dart';
import 'package:fayoum_club_management/features/activites/presentation/manager/delete_activity_cubit/delete_activity_cubit.dart';
import 'package:fayoum_club_management/features/activites/presentation/manager/delete_activity_cubit/delete_activity_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/functions/app_snack_bars.dart';
import '../../../../core/routes/app_router.dart';

class DeleteActivityDialog extends StatelessWidget {
  const DeleteActivityDialog({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<DeleteActivityCubit, DeleteActivityState>(
      listener: (context, state) {
        if (state is DeleteActivitySuccess) {
          context.read<ActivitesCubit>().getActivites();
          GoRouter.of(context).go(AppRouter.homePage);
          primarySnackBar(
            context,
           'تم حذف النشاط بنجاح',
            icon: Icons.check_circle_outline,
            boxColor: AppColors.greenColor,
          );

        } else if (state is DeleteActivityFailure) {
          GoRouter.of(context).pop();
          primarySnackBar(
            context,
            state.error.message??state.error.status,
            icon: Icons.error_outline,
            boxColor: AppColors.redColor,
          );
        }
      },
      builder: (context, state) {
        return ConfirmationDialogWithHorizontalButtons(
          firstButtonFlex: 1,
          secondButtonFlex: 1,
          isLoading: state is DeleteActivityLoading,
          iconData: Iconsax.trash,
          iconColor: AppColors.redColor.withValues(alpha: 0.85),
          title: 'حذف النشاط',
          message: "هل أنت متأكد أنك تريد حذف النشاط؟",
          confirmText: AppStrings.confirm.tr(),
          cancelText: AppStrings.no.tr(),
          onConfirm: () {
            context.read<DeleteActivityCubit>().deleteActivity(id);
          },
          onCancel: () => GoRouter.of(context).pop(),
        );
      },
    );
  }
}
