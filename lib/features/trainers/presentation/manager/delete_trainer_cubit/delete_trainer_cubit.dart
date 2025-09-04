import 'package:fayoum_club_management/features/trainers/data/repos/delete_trainer_repo/delete_trainer_repo.dart';
import 'package:fayoum_club_management/features/trainers/presentation/manager/delete_trainer_cubit/delete_trainer_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteTrainerCubit extends Cubit<DeleteTrainerState> {
  final DeleteTrainerRepo deleteTrainerRepo;

  DeleteTrainerCubit({required this.deleteTrainerRepo})
    : super(DeleteTrainerInitial());

  Future<void> deleteTrainer({required int id}) async {
    emit(DeleteTrainerLoading(id));

    final result = await deleteTrainerRepo.deleteTrainer(id: id);

    if (result.status == 'success') {
      emit(DeleteTrainerSuccess(result));
    } else {
      emit(DeleteTrainerFailure(result));
    }
  }
}
