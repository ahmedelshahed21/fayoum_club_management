import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:fayoum_club_management/core/data/models/validation_model.dart';
import 'package:fayoum_club_management/core/data/models/basic_model.dart';
import 'package:fayoum_club_management/features/activites/data/models/add_new_activity_model/add_new_activity_request_model.dart';

abstract class AddNewActivityRepo {
  Future<Either<ValidationModel, BasicModel>> addNewActivity({
    required AddNewActivityRequestModel requestModel,
    File? image,
  });
}
