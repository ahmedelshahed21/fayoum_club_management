import '../../../../../core/data/models/success_model.dart';

abstract class DeleteActivityRepo {
  Future<SuccessModel> deleteActivity({required int activityId});
}
