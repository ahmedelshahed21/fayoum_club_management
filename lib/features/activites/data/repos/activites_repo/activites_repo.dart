import 'package:dartz/dartz.dart';
import 'package:fayoum_club_management/core/errors/failure.dart';
import 'package:fayoum_club_management/features/activites/data/models/activites_model/activites_model.dart';

abstract class ActivitesRepo {
  Future<Either<Failure, ActivitesModel>> getActivites();
}
