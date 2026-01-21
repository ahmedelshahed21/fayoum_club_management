import '../../../../../core/data/models/success_model.dart';

abstract class DeleteUserRepo {
  Future<SuccessModel> deleteUser({required int userId});
}
