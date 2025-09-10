import '../../../../../core/data/models/success_model.dart';

abstract class DeleteNewsRepo {
  Future<SuccessModel> deleteNews({required int id});
}
