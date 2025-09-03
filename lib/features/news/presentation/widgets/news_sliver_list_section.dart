import 'package:fayoum_club_management/core/functions/dummy_lists.dart';
import 'package:fayoum_club_management/core/widgets/retry_widget.dart';
import 'package:fayoum_club_management/core/widgets/spacing.dart';
import 'package:fayoum_club_management/features/home/presentation/manager/banners_cubit/banners_cubit.dart';
import 'package:fayoum_club_management/features/news/presentation/manager/news_cubit/news_cubit.dart';
import 'package:fayoum_club_management/features/news/presentation/manager/news_cubit/news_state.dart';
import 'package:fayoum_club_management/features/news/presentation/widgets/news_sliver_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class NewsSliverListSection extends StatelessWidget {
  const NewsSliverListSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsCubit, NewsState>(
      builder: (context, state) {
        if (state is NewsLoading) {
          return Skeletonizer.sliver(
            textBoneBorderRadius: TextBoneBorderRadius(
              BorderRadius.circular(4),
            ),
            child: NewsSliverList(news: getDummyBanners()),
          );
        } else if (state is NewsFailure) {
          return SliverToBoxAdapter(
            child: Column(
              children: [
                VerticalSpace(220),
                RetryWidget(
                  message: state.failure.errMessage,
                  onPressed: () {
                    context.read<BannersCubit>().getBanners();
                    context.read<NewsCubit>().getAllNews();
                  },
                ),
              ],
            ),
          );
        } else if (state is NewsSuccess) {
          return state.news.data!.isNotEmpty ? NewsSliverList(news: state.news.data!):SliverToBoxAdapter(child: SizedBox.shrink(),);
        }
        return SliverToBoxAdapter(child: SizedBox.shrink());
      },
    );
  }
}
