import 'package:fayoum_club_management/core/data/models/success_model.dart';

abstract class DeleteTrainerRepo {
  Future<SuccessModel> deleteTrainer({required int id});
}
