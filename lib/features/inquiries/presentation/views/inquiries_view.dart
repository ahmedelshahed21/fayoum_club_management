import 'package:fayoum_club_management/core/widgets/app_indicators.dart';
import 'package:fayoum_club_management/core/widgets/retry_widget.dart';
import 'package:fayoum_club_management/features/inquiries/presentation/manager/inquiries_cubit.dart';
import 'package:fayoum_club_management/features/inquiries/presentation/manager/inquiries_state.dart';
import 'package:fayoum_club_management/features/inquiries/presentation/widgets/inquiries_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InquiriesView extends StatefulWidget {
  const InquiriesView({super.key});

  @override
  State<InquiriesView> createState() => _InquiriesViewState();
}

class _InquiriesViewState extends State<InquiriesView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<InquiriesCubit>().fetchInquiries();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 100) {
        context.read<InquiriesCubit>().fetchInquiries();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryRefreshIndicator(
      onRefresh: ()async{
        context.read<InquiriesCubit>().fetchInquiries(refresh: true);
      },
      child: BlocBuilder<InquiriesCubit, InquiriesState>(
        builder: (context, state) {
          if (state is InquiriesLoading && state is! InquiriesLoaded) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is InquiriesLoaded) {
            return InquiriesListView(
              items: state.items,
              hasMore: state.hasMore,
              scrollController: _scrollController,
            );
          } else if (state is InquiriesError) {
            return RetryWidget(
              message: state.message,
              onPressed: () {
                context.read<InquiriesCubit>().fetchInquiries();
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
