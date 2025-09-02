import 'package:dartz/dartz.dart';
import 'package:fayoum_club_management/features/news/data/models/news_model.dart';
import 'package:fayoum_club_management/core/errors/failure.dart';

abstract class BannersRepo {
  Future<Either<Failure, NewsModel>> getBanners();
}
