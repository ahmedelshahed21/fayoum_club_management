import 'package:dartz/dartz.dart';
import 'package:fayoum_club_management/core/data/models/validation_model.dart';
import 'package:fayoum_club_management/core/data/models/auth_success_model.dart';

abstract class LoginRepo {
  Future<Either<ValidationModel, AuthSuccessModel>> login({
    required String phoneNumber,
    required String password,
  });
}
