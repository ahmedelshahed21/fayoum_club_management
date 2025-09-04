import 'package:easy_localization/easy_localization.dart';
import 'package:fayoum_club_management/core/utils/app_assets.dart';
import 'package:fayoum_club_management/core/widgets/confirmation_dialog_with_horizontal_buttons.dart';
import 'package:fayoum_club_management/features/trainers/presentation/manager/delete_trainer_cubit/delete_trainer_cubit.dart';
import 'package:fayoum_club_management/features/trainers/presentation/manager/delete_trainer_cubit/delete_trainer_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/functions/app_snack_bars.dart';
import '../../../../core/routes/app_router.dart';

class DeleteTrainerDialog extends StatelessWidget {
  const DeleteTrainerDialog({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeleteTrainerCubit, DeleteTrainerState>(
      listener: (context, state) {
        if (state is DeleteTrainerSuccess) {
          GoRouter.of(context).go(AppRouter.homePage);
          primarySnackBar(
            context,
            'تم حذف المدرب بنجاح',
            icon: Icons.check_circle_outline,
            boxColor: AppColors.greenColor,
          );
        } else if (state is DeleteTrainerFailure) {
          GoRouter.of(context).pop();
          primarySnackBar(
            context,
            state.error.message ?? state.error.status,
            icon: Icons.error_outline,
            boxColor: AppColors.redColor,
          );
        }
      },
      builder: (context, state) {
        return ConfirmationDialogWithHorizontalButtons(
          firstButtonFlex: 1,
          secondButtonFlex: 1,
          isLoading: state is DeleteTrainerLoading,
          iconAsset: AppAssets.deleteAccountIcon,
          iconColor: AppColors.redColor.withValues(alpha: 0.85),
          title: 'حذف المدرب',
          message: "هل أنت متأكد أنك تريد حذف هذا المدرب؟",
          confirmText: AppStrings.confirm.tr(),
          cancelText: AppStrings.no.tr(),
          onConfirm: () {
            context.read<DeleteTrainerCubit>().deleteTrainer(id: id);
          },
          onCancel: () => GoRouter.of(context).pop(),
        );
      },
    );
  }
}
