import 'package:fayoum_club_management/core/functions/dummy_lists.dart';
import 'package:fayoum_club_management/core/widgets/app_app_bars.dart';
import 'package:fayoum_club_management/features/users/presentation/manager/users_cubit/users_cubit.dart';
import 'package:fayoum_club_management/features/users/presentation/manager/users_cubit/users_state.dart';
import 'package:fayoum_club_management/features/users/presentation/widgets/user_total_header.dart';
import 'package:fayoum_club_management/features/users/presentation/widgets/users_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fayoum_club_management/core/widgets/app_indicators.dart';
import 'package:fayoum_club_management/core/widgets/retry_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class UsersView extends StatefulWidget {
  const UsersView({super.key});

  @override
  State<UsersView> createState() => _UsersViewState();
}

class _UsersViewState extends State<UsersView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<UsersCubit>().fetchUsers();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final cubit = context.read<UsersCubit>();
    final state = cubit.state;

    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100) {
      if (state is UsersLoaded && state.hasMore) {
        cubit.fetchUsers();
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(title: 'المستخدمون'),
      body: PrimaryRefreshIndicator(
        onRefresh: () async {
          await context.read<UsersCubit>().fetchUsers(refresh: true);
        },
        child: BlocBuilder<UsersCubit, UsersState>(
          builder: (context, state) {
            if (state is UsersLoading) {
              return Skeletonizer(
                // containersColor: AppColors.lightGreyColor,
                textBoneBorderRadius: TextBoneBorderRadius(BorderRadius.circular(4)),
                child: Column(
                  children: [
                    UsersTotalHeader(total: getDummyUsers().length),
                    Expanded(
                      child: UsersListView(
                        items: getDummyUsers(),
                        hasMore: false,
                        scrollController: _scrollController,
                      ),
                    ),
                  ],
                ),
              );
            }

            if (state is UsersLoaded) {
              return Column(
                children: [
                  UsersTotalHeader(total: state.total),
                  Expanded(
                    child: UsersListView(
                      items: state.items,
                      hasMore: state.hasMore,
                      scrollController: _scrollController,
                    ),
                  ),
                ],
              );
            }

            if (state is UsersError) {
              return RetryWidget(
                message: state.message,
                onPressed: () {
                  context.read<UsersCubit>().fetchUsers(refresh: true);
                },
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}










