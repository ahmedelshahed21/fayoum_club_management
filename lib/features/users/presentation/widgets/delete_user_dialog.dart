import 'package:easy_localization/easy_localization.dart';
import 'package:fayoum_club_management/core/functions/app_snack_bars.dart';
import 'package:fayoum_club_management/core/utils/app_colors.dart';
import 'package:fayoum_club_management/core/utils/app_strings.dart';
import 'package:fayoum_club_management/core/widgets/confirmation_dialog_with_horizontal_buttons.dart';
import 'package:fayoum_club_management/features/users/presentation/manager/delete_user_cubit/delete_user_cubit.dart';
import 'package:fayoum_club_management/features/users/presentation/manager/delete_user_cubit/delete_user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class DeleteUserDialog extends StatelessWidget {
  final int userId;

  const DeleteUserDialog({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeleteUserCubit, DeleteUserState>(
      listener: (context, state) {
        if (state is DeleteUserSuccess) {
          Navigator.of(context).pop();
          primarySnackBar(
            context,
            'تم حذف المستخدم بنجاح',
            icon: Icons.check_circle_outline,
            boxColor: AppColors.greenColor,
          );

        } else if (state is DeleteUserFailure) {
          Navigator.of(context).pop();
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
          isLoading: state is DeleteUserLoading,
          iconData: Iconsax.trash,
          iconColor: AppColors.redColor.withValues(alpha: .85),
          title: 'حذف المستخدم',
          message: 'هل أنت متأكد أنك تريد حذف هذا المستخدم؟',
          confirmText: AppStrings.confirm.tr(),
          cancelText: AppStrings.no.tr(),
          onConfirm: () {
            context.read<DeleteUserCubit>().deleteUser(userId: userId);
          },
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }
}
