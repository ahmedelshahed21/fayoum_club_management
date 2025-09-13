import 'package:dartz/dartz.dart';
import 'package:fayoum_club_management/core/errors/failure.dart';
import 'package:fayoum_club_management/features/subscriptions/data/models/activities_subscriptions_model/activities_subscriptions_model.dart';

abstract class ActivitiesSubscriptionsRepo {
  Future<Either<Failure, ActivitiesSubscriptionsModel>> getActivitiesSubscriptions({
    int page = 1,
    int perPage = 5,
  });
}
