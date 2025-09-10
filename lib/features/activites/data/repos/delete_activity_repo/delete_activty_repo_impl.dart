import 'package:easy_localization/easy_localization.dart';
import 'package:fayoum_club_management/core/data/models/success_model.dart';
import 'package:fayoum_club_management/core/databases/api/dio_consumer.dart';
import 'package:fayoum_club_management/core/databases/cache/secure_storage_helper.dart';
import 'package:fayoum_club_management/core/state_management/network_connection_cubit/network_connection_cubit.dart';
import 'package:fayoum_club_management/core/utils/app_strings.dart';
import 'package:fayoum_club_management/core/utils/end_points.dart';
import 'package:fayoum_club_management/features/activites/data/repos/delete_activity_repo/delete_activity_repo.dart';

class DeleteActivityRepoImpl implements DeleteActivityRepo {
  final DioConsumer dioConsumer;
  final SecureStorageHelper secureStorageHelper;
  final NetworkConnectionCubit networkCubit;

  DeleteActivityRepoImpl({
    required this.dioConsumer,
    required this.secureStorageHelper,
    required this.networkCubit,
  });

  @override
  Future<SuccessModel> deleteActivity({required int activityId}) async {
    final isConnected = await networkCubit.networkInfo.isConnected;

    if (!isConnected) {
      return SuccessModel(
        version: 1,
        code: 0,
        status: "failed",
        message: AppStrings.noInternetConnection.tr(),
        data: null,
      );
    }

    final token = await secureStorageHelper.getToken();

    try {
      final response = await dioConsumer.delete(
        EndPoints.deleteActivity(id: activityId),
        headers: {Params.authorization: '${Params.bearer} $token'},
      );

      if (response != null && response is Map<String, dynamic>) {
        if (response[ApiKey.code] >= 200 && response[ApiKey.code] < 400) {
          return SuccessModel.fromJson(response);
        } else {
          return SuccessModel.fromJson(response);
        }
      } else {
        return SuccessModel(
          version: 1,
          code: 0,
          status: "failed",
          message: AppStrings.serverConnectionFailed.tr(),
          data: null,
        );
      }
    } catch (e) {
      return SuccessModel(
        version: 1,
        code: 0,
        status: "failed",
        message: AppStrings.unexpectedError.tr(),
        data: null,
      );
    }
  }
}
