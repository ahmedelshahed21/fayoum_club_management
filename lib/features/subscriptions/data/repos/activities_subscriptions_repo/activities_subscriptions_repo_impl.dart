import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fayoum_club_management/core/databases/api/dio_consumer.dart';
import 'package:fayoum_club_management/core/databases/cache/secure_storage_helper.dart';
import 'package:fayoum_club_management/core/errors/failure.dart';
import 'package:fayoum_club_management/core/state_management/network_connection_cubit/network_connection_cubit.dart';
import 'package:fayoum_club_management/core/utils/app_strings.dart';
import 'package:fayoum_club_management/core/utils/end_points.dart';
import 'package:fayoum_club_management/features/subscriptions/data/models/activities_subscriptions_model/activities_subscriptions_model.dart';
import 'package:fayoum_club_management/features/subscriptions/data/repos/activities_subscriptions_repo/activities_subscriptions_repo.dart';

class ActivitiesSubscriptionsRepoImpl implements ActivitiesSubscriptionsRepo {
  final DioConsumer dioConsumer;
  final NetworkConnectionCubit networkCubit;
  final SecureStorageHelper secureStorageHelper;

  ActivitiesSubscriptionsRepoImpl({
    required this.dioConsumer,
    required this.networkCubit,
    required this.secureStorageHelper,
  });

  @override
  Future<Either<Failure, ActivitiesSubscriptionsModel>> getActivitiesSubscriptions({
    int page = 1,
    int perPage = 5,
  }) async {
    final isConnected = await networkCubit.networkInfo.isConnected;

    if (!isConnected) {
      return Left(
        NoInternetFailure(errMessage: AppStrings.noInternetConnection.tr()),
      );
    }

    final token = await secureStorageHelper.getToken();

    try {
      final response = await dioConsumer.get(
        '/admin/mony-pay',
        queryParameters: {
          Params.page: page,
          ApiKey.perPage: perPage,
        },
        headers: {
          Params.authorization: '${Params.bearer} $token',
        },
      );
// print(response);
      if (response != null && response is Map<String, dynamic>) {
        if (response[ApiKey.code] == 200) {
          final model = ActivitiesSubscriptionsModel.fromJson(response);
          return Right(model);
        } else {
          return Left(
            ServerFailure(errMessage: AppStrings.serverConnectionFailed.tr()),
          );
        }
      } else {
        return Left(
          ServerFailure(errMessage: AppStrings.serverConnectionFailed.tr()),
        );
      }
    } catch (e) {
      print(e.toString());
      return Left(
        ServerFailure(errMessage: AppStrings.serverConnectionFailed.tr()),
      );
    }
  }
}
