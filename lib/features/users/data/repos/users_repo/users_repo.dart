import 'package:dartz/dartz.dart';
import 'package:fayoum_club_management/core/errors/failure.dart';
import 'package:fayoum_club_management/features/users/data/models/users_model/users_model.dart';

abstract class UsersRepo {
  Future<Either<Failure, UsersModel>> getUsers({
    int page,
    int perPage,
  });
}
