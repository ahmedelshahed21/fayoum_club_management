import 'package:fayoum_club_management/features/home/data/models/banners_models/urgent_news_model.dart';
import 'package:fayoum_club_management/core/errors/failure.dart';
import 'package:fayoum_club_management/features/home/data/repos/banners_repo/banners_repo.dart';
import 'package:fayoum_club_management/features/home/presentation/manager/banners_cubit/banners_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BannersCubit extends Cubit<BannersState> {
  final BannersRepo news;

  BannersCubit({required this.news}) : super(const BannersInitial());

  Future<void> getBanners() async {
    emit(const BannersLoading());

    final Either<Failure, UrgentNewsModel> result = await news.getBanners();

    result.fold(
      (failure) => emit(BannersFailure(failure)),
      (bannersModel) => emit(BannersSuccess(bannersModel)),
    );
  }
}
