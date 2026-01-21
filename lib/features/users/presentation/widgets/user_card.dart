import 'package:fayoum_club_management/core/functions/run_if_connected.dart';
import 'package:fayoum_club_management/core/services/service_locator.dart';
import 'package:fayoum_club_management/core/utils/app_colors.dart';
import 'package:fayoum_club_management/core/utils/app_styles.dart';
import 'package:fayoum_club_management/core/widgets/spacing.dart';
import 'package:fayoum_club_management/features/users/presentation/manager/delete_user_cubit/delete_user_cubit.dart';
import 'package:fayoum_club_management/features/users/presentation/widgets/delete_user_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCard extends StatelessWidget {
  final dynamic item;

  const UserCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        runIfConnected(
          context: context,
          onConnected: () {
            showDialog(
              context: context,
              builder: (_) {
                return BlocProvider(
                  create: (_) => getIt<DeleteUserCubit>(),
                  child: DeleteUserDialog(userId: item.id),
                );
              },
            );
          },
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.pureWhiteColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: AppColors.lightGreyColor.withValues(alpha: .6),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .05),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Avatar
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primaryColor,
                      AppColors.notPrimaryColor,
                    ],
                  ),
                ),
                child: CircleAvatar(
                  radius: 26,
                  backgroundColor: AppColors.offWhiteColor,
                  child: Text(
                    item.name.substring(0, 1).toUpperCase(),
                    style: AppStyles.styleExtraBold18(context),
                  ),
                ),
              ),

              const HorizontalSpace(14),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyles.styleSemiBold16(context),
                    ),
                    const VerticalSpace(8),
                    _InfoRow(
                      icon: Icons.email_outlined,
                      text: item.email,
                      context: context,
                    ),
                    const VerticalSpace(6),
                    _InfoRow(
                      icon: Icons.phone_outlined,
                      text: item.phone,
                      context: context,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final BuildContext context;

  const _InfoRow({
    required this.icon,
    required this.text,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withValues(alpha: .08),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: 16,
            color: AppColors.primaryColor,
          ),
        ),
        const HorizontalSpace(8),
        Expanded(
          child: Text(
            text,
            overflow: TextOverflow.ellipsis,
            style: AppStyles.styleRegular14(context),
          ),
        ),
      ],
    );
  }
}
