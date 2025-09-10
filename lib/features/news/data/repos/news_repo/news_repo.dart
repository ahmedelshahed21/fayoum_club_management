import 'package:dartz/dartz.dart';
import 'package:fayoum_club_management/features/news/data/models/news_model.dart';
import 'package:fayoum_club_management/core/errors/failure.dart';

abstract class NewsRepo {
  Future<Either<Failure, NewsModel>> getAllNews({int page = 1,int? activityId,int? status,String? typeOption});
}
