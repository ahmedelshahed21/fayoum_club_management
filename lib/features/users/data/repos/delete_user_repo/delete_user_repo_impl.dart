import 'package:easy_localization/easy_localization.dart';
import 'package:fayoum_club_management/core/data/models/success_model.dart';
import 'package:fayoum_club_management/core/databases/api/dio_consumer.dart';
import 'package:fayoum_club_management/core/databases/cache/secure_storage_helper.dart';
import 'package:fayoum_club_management/core/state_management/network_connection_cubit/network_connection_cubit.dart';
import 'package:fayoum_club_management/core/utils/app_strings.dart';
import 'package:fayoum_club_management/core/utils/end_points.dart';
import 'delete_user_repo.dart';

class DeleteUserRepoImpl implements DeleteUserRepo {
  final DioConsumer dioConsumer;
  final SecureStorageHelper secureStorageHelper;
  final NetworkConnectionCubit networkCubit;

  DeleteUserRepoImpl({
    required this.dioConsumer,
    required this.secureStorageHelper,
    required this.networkCubit,
  });

  @override
  Future<SuccessModel> deleteUser({required int userId}) async {
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
        EndPoints.deleteUser(id: userId),
        headers: {
          Params.authorization: '${Params.bearer} $token',
        },
      );

      if (response != null && response is Map<String, dynamic>) {
        return SuccessModel.fromJson(response);
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
