import 'package:easy_localization/easy_localization.dart';
import 'package:fayoum_club_management/core/widgets/confirmation_dialog_with_horizontal_buttons.dart';
import 'package:fayoum_club_management/features/news/presentation/manager/delete_news_cubit/delete_news_cubit.dart';
import 'package:fayoum_club_management/features/news/presentation/manager/delete_news_cubit/delete_news_state.dart';
import 'package:fayoum_club_management/features/news/presentation/manager/news_cubit/news_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/functions/app_snack_bars.dart';
import '../../../../core/routes/app_router.dart';

class DeleteNewsDialog extends StatelessWidget {
  const DeleteNewsDialog({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeleteNewsCubit, DeleteNewsState>(
      listener: (context, state) {
        if (state is DeleteNewsSuccess) {
          context.read<NewsCubit>().fetchNews(refresh: true);
          GoRouter.of(context).go(AppRouter.homePage);
          primarySnackBar(
            context,
            'تم حذف الخبر بنجاح',
            icon: Icons.check_circle_outline,
            boxColor: AppColors.greenColor,
          );
        } else if (state is DeleteNewsFailure) {
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
          isLoading: state is DeleteNewsLoading,
          iconData: Iconsax.trash,
          iconColor: AppColors.redColor.withValues(alpha: 0.85),
          title: 'حذف الخبر',
          message: "هل أنت متأكد أنك تريد حذف الخبر؟",
          confirmText: AppStrings.confirm.tr(),
          cancelText: AppStrings.no.tr(),
          onConfirm: () {
            context.read<DeleteNewsCubit>().deleteNews(id: id);
          },
          onCancel: () => GoRouter.of(context).pop(),
        );
      },
    );
  }
}
