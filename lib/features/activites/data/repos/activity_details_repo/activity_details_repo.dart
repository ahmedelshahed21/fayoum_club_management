import 'package:dartz/dartz.dart';
import 'package:fayoum_club_management/core/errors/failure.dart';
import 'package:fayoum_club_management/features/activites/data/models/activity_details_model/activity_details_model.dart'
    show ActivityDetailsModel;

abstract class ActivityDetailsRepo {
  Future<Either<Failure, ActivityDetailsModel>> getActivityDetails({
    required int activityId,
  });
}
