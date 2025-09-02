import '../../../../../core/data/models/basic_model.dart';

abstract class DeleteActivityRepo {
  Future<BasicModel> deleteActivity({required int id});
}
