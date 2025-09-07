import 'package:easy_localization/easy_localization.dart';
import 'package:fayoum_club_management/core/widgets/confirmation_dialog_with_horizontal_buttons.dart';
import 'package:fayoum_club_management/features/inquiries/presentation/manager/delete_inquiry_cubit/delete_inquiry_cubit.dart';
import 'package:fayoum_club_management/features/inquiries/presentation/manager/delete_inquiry_cubit/delete_inquiry_state.dart';
import 'package:fayoum_club_management/features/inquiries/presentation/manager/inquiries_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/functions/app_snack_bars.dart';

class DeleteInquiryDialog extends StatelessWidget {
  const DeleteInquiryDialog({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeleteInquiryCubit, DeleteInquiryState>(
      listener: (context, state) {
        if (state is DeleteInquirySuccess) {
          context.read<InquiriesCubit>().fetchInquiries(refresh: true);
          Navigator.of(context).pop();
          primarySnackBar(
            context,
            'تم حذف الاستفسار بنجاح',
            icon: Icons.check_circle_outline,
            boxColor: AppColors.greenColor,
          );
        } else if (state is DeleteInquiryFailure) {
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
          isLoading: state is DeleteInquiryLoading,
          iconData: Iconsax.trash,
          iconColor: AppColors.redColor.withValues(alpha: 0.85),
          title: 'حذف الاستفسار',
          message: "هل أنت متأكد أنك تريد حذف الاستفسار؟",
          confirmText: AppStrings.confirm.tr(),
          cancelText: AppStrings.no.tr(),
          onConfirm: () {
            context.read<DeleteInquiryCubit>().deleteInquiry(id);
          },
          onCancel: () => GoRouter.of(context).pop(),
        );
      },
    );
  }
}
