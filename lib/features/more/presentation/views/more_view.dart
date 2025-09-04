import 'package:fayoum_club_management/core/state_management/user_cubit/user_session_cubit.dart';
import 'package:fayoum_club_management/core/widgets/guest_circle_avatar.dart';
import 'package:fayoum_club_management/features/more/presentation/widgets/account_section.dart';
import 'package:fayoum_club_management/features/more/presentation/widgets/logout_section.dart';
import 'package:fayoum_club_management/features/more/presentation/widgets/more_view_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/spacing.dart';

class MoreView extends StatelessWidget {
  const MoreView({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isGuest = context.select<UserSessionCubit, bool>(
      (cubit) => cubit.state.isGuest,
    );
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        // physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const VerticalSpace(16),
            isGuest ? const GuestCircleAvatar() : const MoreViewHeader(),
            Spacer(),
            isGuest ? const SizedBox.shrink() : const AccountSection(),
            // const VerticalSpace(16),
            // const SettingsSection(),
            // const VerticalSpace(16),
            // const HelpSection(),
            // const VerticalSpace(16),
            // const AboutSection(),
            const VerticalSpace(48),
            const LogoutSection(),
            Spacer(flex: 2),
            // const VerticalSpace(24),
          ],
        ),
      ),
    );
  }
}
