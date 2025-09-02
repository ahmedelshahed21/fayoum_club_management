import '../../../../../core/data/models/basic_model.dart';

abstract class DeleteNewsRepo {
  Future<BasicModel> deleteNews({required int id});
}
