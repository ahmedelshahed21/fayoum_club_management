import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fayoum_club_management/core/databases/cache/secure_storage_helper.dart';
import 'package:fayoum_club_management/core/utils/app_strings.dart';
import 'package:fayoum_club_management/core/utils/end_points.dart';
import 'package:fayoum_club_management/core/databases/api/dio_consumer.dart';
import 'package:fayoum_club_management/core/errors/failure.dart';
import 'package:fayoum_club_management/core/state_management/network_connection_cubit/network_connection_cubit.dart';
import 'package:fayoum_club_management/features/inquiries/data/models/inquiries_model.dart';
import 'package:fayoum_club_management/features/inquiries/data/repos/inquiries_repo/inquiries_repo.dart';

class InquiriesRepoImpl implements InquiriesRepo {
  final DioConsumer dioConsumer;
  final NetworkConnectionCubit networkCubit;
  final SecureStorageHelper secureStorageHelper;

  InquiriesRepoImpl({
    required this.dioConsumer,
    required this.networkCubit,
    required this.secureStorageHelper
  });



  @override
  Future<Either<Failure, InquiriesModel>> getInquiries({int page = 1}) async {
    final isConnected = await networkCubit.networkInfo.isConnected;

    if (!isConnected) {
      return Left(
        NoInternetFailure(errMessage: AppStrings.noInternetConnection.tr()),
      );
    }
    final token = await secureStorageHelper.getToken();
    try {

      final response = await dioConsumer.get(EndPoints.inquiries,
        queryParameters: {
        Params.page:page,
          'perPage':5
        },
        headers: {
        Params.authorization:'${Params.bearer} $token'
        }
      );
      if (response != null && response is Map<String, dynamic>) {
        if (response[ApiKey.code] == 200) {
          final inquiriesModel = InquiriesModel.fromJson(response);
          return Right(inquiriesModel);
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
      return Left(
        ServerFailure(errMessage: AppStrings.serverConnectionFailed.tr()),
      );
    }
  }
}
