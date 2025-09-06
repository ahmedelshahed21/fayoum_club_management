import 'package:dartz/dartz.dart';
import 'package:fayoum_club_management/features/home/data/models/banners_models/urgent_news_model.dart';
import 'package:fayoum_club_management/core/errors/failure.dart';

abstract class BannersRepo {
  Future<Either<Failure, UrgentNewsModel>> getBanners();
}
