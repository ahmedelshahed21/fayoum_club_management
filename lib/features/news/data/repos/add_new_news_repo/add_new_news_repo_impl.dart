import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fayoum_club_management/core/constants/app_strings.dart';
import 'package:fayoum_club_management/core/constants/end_points.dart';
import 'package:fayoum_club_management/core/data/models/auth_failure_model.dart';
import 'package:fayoum_club_management/core/data/models/basic_model.dart';
import 'package:fayoum_club_management/core/databases/api/dio_consumer.dart';
import 'package:fayoum_club_management/core/databases/cache/secure_storage_helper.dart';
import 'package:fayoum_club_management/core/state_management/network_connection_cubit/network_connection_cubit.dart';
import 'package:fayoum_club_management/features/news/data/models/add_new_news_request_model/add_new_news_request_model.dart';
import 'package:fayoum_club_management/features/news/data/repos/add_new_news_repo/add_new_news_repo.dart';

class AddNewNewsRepoImpl implements AddNewNewsRepo {
  final DioConsumer dioConsumer;
  final SecureStorageHelper secureStorageHelper;
  final NetworkConnectionCubit networkCubit;

  AddNewNewsRepoImpl({
    required this.dioConsumer,
    required this.secureStorageHelper,
    required this.networkCubit,
  });

  @override
  Future<Either<AuthFailureModel, BasicModel>> addNewNews({
    required AddNewNewsRequestModel requestModel,
    File? image,
  }) async {
    final isConnected = await networkCubit.networkInfo.isConnected;

    if (!isConnected) {
      return Left(
        AuthFailureModel(
          status: "error",
          message: AppStrings.noInternetConnection.tr(),
          errors: [AppStrings.noInternetConnection.tr()],
          code: 0,
        ),
      );
    }

    final token = await secureStorageHelper.getToken();

    try {
      final formData = FormData.fromMap({
        ...requestModel.toJson(),
        if (image != null)
          ApiKey.image: await MultipartFile.fromFile(
            image.path,
            filename: image.path.split('/').last,
          ),
      });

      final response = await dioConsumer.post(
        EndPoints.addNewNews,
        headers: {
          Params.authorization: '${Params.bearer} $token',
        },
        data: formData,
      );

      if (response != null && response is Map<String, dynamic>) {
        if (response[ApiKey.code] >= 200 && response[ApiKey.code] < 400) {
          return Right(BasicModel.fromJson(response));
        } else {
          return Left(AuthFailureModel.fromJson(response));
        }
      } else {
        return Left(
          AuthFailureModel(
            status: "error",
            message: AppStrings.serverConnectionFailed.tr(),
            errors: [AppStrings.serverConnectionFailed.tr()],
            code: -1,
          ),
        );
      }
    } catch (e) {
      return Left(
        AuthFailureModel(
          status: "error",
          message: AppStrings.unexpectedError.tr(),
          errors: [AppStrings.unexpectedError.tr()],
          code: -2,
        ),
      );
    }
  }
}
