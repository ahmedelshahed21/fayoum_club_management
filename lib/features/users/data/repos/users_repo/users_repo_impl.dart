import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fayoum_club_management/core/databases/api/dio_consumer.dart';
import 'package:fayoum_club_management/core/databases/cache/secure_storage_helper.dart';
import 'package:fayoum_club_management/core/errors/failure.dart';
import 'package:fayoum_club_management/core/state_management/network_connection_cubit/network_connection_cubit.dart';
import 'package:fayoum_club_management/core/utils/app_strings.dart';
import 'package:fayoum_club_management/core/utils/end_points.dart';
import 'package:fayoum_club_management/features/users/data/models/users_model/users_model.dart';
import 'package:fayoum_club_management/features/users/data/repos/users_repo/users_repo.dart';

class UsersRepoImpl implements UsersRepo {
  final DioConsumer dioConsumer;
  final NetworkConnectionCubit networkCubit;
  final SecureStorageHelper secureStorageHelper;

  UsersRepoImpl({
    required this.dioConsumer,
    required this.networkCubit,
    required this.secureStorageHelper,
  });

  @override
  Future<Either<Failure, UsersModel>> getUsers({
    int page = 1,
    int perPage = 10,
  }) async {
    final isConnected = await networkCubit.networkInfo.isConnected;

    if (!isConnected) {
      return Left(
        NoInternetFailure(
          errMessage: AppStrings.noInternetConnection.tr(),
        ),
      );
    }

    final token = await secureStorageHelper.getToken();

    try {
      final response = await dioConsumer.get(
        EndPoints.users,
        queryParameters: {
          Params.page: page,
          ApiKey.perPage: perPage,
        },
        headers: {
          Params.authorization: '${Params.bearer} $token',
        },
      );

      if (response != null && response is Map<String, dynamic>) {
        if (response[ApiKey.code] == 200) {
          final model = UsersModel.fromJson(response);
          return Right(model);
        } else {
          return Left(
            ServerFailure(
              errMessage: AppStrings.serverConnectionFailed.tr(),
            ),
          );
        }
      } else {
        return Left(
          ServerFailure(
            errMessage: AppStrings.serverConnectionFailed.tr(),
          ),
        );
      }
    } catch (e) {
      return Left(
        ServerFailure(
          errMessage: AppStrings.serverConnectionFailed.tr(),
        ),
      );
    }
  }
}
