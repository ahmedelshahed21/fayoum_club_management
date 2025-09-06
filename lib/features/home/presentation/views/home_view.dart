import 'package:fayoum_club_management/core/functions/internet_connection_status_snack_bar.dart';
import 'package:fayoum_club_management/core/state_management/network_connection_cubit/network_connection_cubit.dart';
import 'package:fayoum_club_management/core/state_management/network_connection_cubit/network_connection_state.dart';
import 'package:fayoum_club_management/core/widgets/app_indicators.dart';
import 'package:fayoum_club_management/core/widgets/spacing.dart';
import 'package:fayoum_club_management/features/activites/presentation/manager/activites_cubit/activites_cubit.dart';
import 'package:fayoum_club_management/features/home/presentation/manager/banners_cubit/banners_cubit.dart';
import 'package:fayoum_club_management/features/home/presentation/widgets/banners_section.dart';
import 'package:fayoum_club_management/features/news/presentation/manager/news_cubit/news_cubit.dart';
import 'package:fayoum_club_management/features/news/presentation/widgets/news_sliver_list_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();

}

class _HomeViewState extends State<HomeView> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 100) {
        context.read<NewsCubit>().fetchNews();
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return BlocListener<NetworkConnectionCubit, NetworkConnectionState>(
      listener: (context, state) {
        if (state is NetworkConnected) {
          internetConnectionStatusSnackBar(context, isConnected: true);
        } else if (state is NetworkDisconnected) {
          internetConnectionStatusSnackBar(context, isConnected: false);
        }
      },
      // builder: (context, state) {
      //   if (state is NetworkDisconnected) {
      //     return Center(
      //       child: NoInternetConnectionContainer(
      //         message: AppStrings.noInternetConnection.tr(),
      //       ),
      //     );
      //   }
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: PrimaryRefreshIndicator(
          onRefresh: () async {
            context.read<BannersCubit>().getBanners();
            context.read<ActivitesCubit>().getActivites();
            context.read<NewsCubit>().fetchNews(refresh: true);
          },
          child: CustomScrollView(
            controller: _scrollController,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const VerticalSpace(16),
                    const BannersSection(),
                    // const VerticalSpace(12),
                    // ActivitesHorizontalListViewSection(),
                  ],
                ),
              ),
              SliverToBoxAdapter(child: const VerticalSpace(12)),
              NewsSliverListSection(),
            ],
          ),
        ),
      ),
    );
  }
}
