import 'package:easy_localization/easy_localization.dart';
import 'package:fayoum_club_management/core/databases/cache/secure_storage_helper.dart';
import 'package:fayoum_club_management/core/functions/navigation.dart';
import 'package:fayoum_club_management/core/state_management/bottom_navigation_bar_cubit/bottom_navigation_bar_cubit.dart';
import 'package:fayoum_club_management/core/state_management/user_cubit/user_session_cubit.dart';
import 'package:fayoum_club_management/core/widgets/confirmation_dialog_with_horizontal_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/databases/cache/user_data_manager.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/services/service_locator.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final UserDataManager userDataManager = getIt<UserDataManager>();
    final SecureStorageHelper secureStorageHelper = getIt<SecureStorageHelper>();
    return ConfirmationDialogWithHorizontalButtons(
      isLoading: false,
      iconData: Iconsax.logout_copy,
      iconAsset: AppAssets.logoutIcon,
      title: AppStrings.logout.tr(),
      message: AppStrings.logoutMessage.tr(),
      confirmText: AppStrings.logout.tr(),
      cancelText: AppStrings.no.tr(),
      onConfirm: () async{
        await secureStorageHelper.deleteToken();
        userDataManager.clearAllUserData();
        if(context.mounted) {
          context.read<BottomNavigationBarCubit>().changeIndex(0);
          context.read<UserSessionCubit>().setGuestStatus(isGuest: true);
          customGo(context, AppRouter.loginView);
        }

      },
      onCancel: () => GoRouter.of(context).pop(),
    );
  }
}
