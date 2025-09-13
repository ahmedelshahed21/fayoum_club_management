import 'package:fayoum_club_management/core/widgets/app_app_bars.dart';
import 'package:fayoum_club_management/core/widgets/app_indicators.dart';
import 'package:fayoum_club_management/core/widgets/retry_widget.dart';
import 'package:fayoum_club_management/features/inquiries/presentation/manager/inquiries_cubit.dart';
import 'package:fayoum_club_management/features/subscriptions/presentation/manager/activities_subscriptions_cubit/activities_subscriptions_cubit.dart';
import 'package:fayoum_club_management/features/subscriptions/presentation/manager/activities_subscriptions_cubit/activities_subscriptions_state.dart';
import 'package:fayoum_club_management/features/subscriptions/presentation/widgets/activities_subscriptions_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActivitiesSubscriptionsView extends StatefulWidget {
  const ActivitiesSubscriptionsView({super.key});

  @override
  State<ActivitiesSubscriptionsView> createState() => _ActivitiesSubscriptionsViewState();
}

class _ActivitiesSubscriptionsViewState extends State<ActivitiesSubscriptionsView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<ActivitiesSubscriptionsCubit>().fetchSubscriptions();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 100) {
        context.read<InquiriesCubit>().fetchInquiries();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(title: 'الاشتراكات'),
      body: PrimaryRefreshIndicator(
        onRefresh: ()async{
          context.read<ActivitiesSubscriptionsCubit>().fetchSubscriptions(refresh: true);
        },
        child: BlocBuilder<ActivitiesSubscriptionsCubit, ActivitiesSubscriptionsState>(
          builder: (context, state) {
            if (state is ActivitiesSubscriptionsLoading && state is! ActivitiesSubscriptionsLoaded) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ActivitiesSubscriptionsLoaded) {
              return ActivitiesSubscriptionsListView(
                items: state.items,
                hasMore: state.hasMore,
                scrollController: _scrollController,
              );
            } else if (state is ActivitiesSubscriptionsError) {
              return RetryWidget(
                message: state.message,
                onPressed: () {
                  context.read<ActivitiesSubscriptionsCubit>().fetchSubscriptions();
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
