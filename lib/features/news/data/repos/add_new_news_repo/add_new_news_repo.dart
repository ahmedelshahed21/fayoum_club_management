import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:fayoum_club_management/core/data/models/validation_model.dart';
import 'package:fayoum_club_management/core/data/models/success_model.dart';
import 'package:fayoum_club_management/features/news/data/models/add_new_news_request_model/add_new_news_request_model.dart';

abstract class AddNewNewsRepo {
  Future<Either<ValidationModel, SuccessModel>> addNewNews({
    required AddNewNewsRequestModel requestModel,
    File? image,
  });
}
