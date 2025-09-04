import 'package:fayoum_club_management/core/data/models/basic_model.dart';

abstract class DeleteTrainerRepo {
  Future<BasicModel> deleteTrainer({required int id});
}
