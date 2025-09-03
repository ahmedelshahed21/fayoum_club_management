import 'package:cached_network_image/cached_network_image.dart';
import 'package:fayoum_club_management/core/services/service_locator.dart';
import 'package:fayoum_club_management/core/widgets/app_app_bars.dart';
import 'package:fayoum_club_management/core/widgets/app_buttons.dart';
import 'package:fayoum_club_management/core/widgets/spacing.dart';
import 'package:fayoum_club_management/core/widgets/tag_widget.dart';
import 'package:fayoum_club_management/features/news/presentation/manager/delete_news_cubit/delete_news_cubit.dart';
import 'package:fayoum_club_management/features/news/presentation/widgets/delete_news_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fayoum_club_management/core/constants/app_colors.dart';
import 'package:fayoum_club_management/core/constants/app_styles.dart';
import 'package:fayoum_club_management/features/news/data/models/news_model.dart';
import 'package:fayoum_club_management/core/widgets/image_loading_effect.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsDetailsView extends StatelessWidget {
  final NewsItem news;

  const NewsDetailsView({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhiteColor,
      appBar: PrimaryAppBar(title: "تفاصيل الخبر"),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(24),
                      bottomRight: Radius.circular(24),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: news.image,
                      height: 220,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const ImageLoadingEffect(),
                      errorWidget:
                          (context, url, error) => Container(
                            height: 220,
                            color: AppColors.lightGreyColor,
                            child: const Icon(
                              Icons.image_not_supported,
                              size: 60,
                            ),
                          ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const VerticalSpace(16),
                        Text(news.title, style: AppStyles.styleBold24(context).copyWith(color: AppColors.pureBlackColor)),
                        const VerticalSpace(8),
                        Row(
                          children: [
                            Text(
                              news.createdAt,
                              style: AppStyles.styleMedium14(context),
                            ),
                            const Spacer(),
                            TagWidget(
                              tag: news.typeOption,
                              backgroundColor: AppColors.primaryColor
                                  .withValues(alpha: 0.3),
                              textColor: AppColors.pureBlackColor,
                            ),
                          ],
                        ),
                        const VerticalSpace(16),
                        Text(
                          news.description,
                          style: AppStyles.styleRegular16(context),
                          textAlign: TextAlign.justify,
                        ),
                        const VerticalSpace(24),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: PrimaryButton(
              backgroundColor: AppColors.redColor,
              text: 'حذف الخبر',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (builder) {
                    return BlocProvider(
                      create:
                          (_) => getIt<DeleteNewsCubit>(),
                      child:  DeleteNewsDialog(id: news.id),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
