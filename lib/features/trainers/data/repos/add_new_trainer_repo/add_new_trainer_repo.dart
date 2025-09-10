import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:fayoum_club_management/core/data/models/validation_model.dart';
import 'package:fayoum_club_management/core/data/models/success_model.dart';
import 'package:fayoum_club_management/features/trainers/data/models/add_new_trainer_request_model.dart';

abstract class AddNewTrainerRepo {
  Future<Either<ValidationModel, SuccessModel>> addNewTrainer({
    required AddNewTrainerRequestModel requestModel,
    File? image,
  });
}
