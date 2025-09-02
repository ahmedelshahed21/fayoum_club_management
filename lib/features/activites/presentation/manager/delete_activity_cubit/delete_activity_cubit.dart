import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fayoum_club_management/features/activites/data/repos/delete_activity_repo/delete_activity_repo.dart';
import 'delete_activity_state.dart';

class DeleteActivityCubit extends Cubit<DeleteActivityState> {
  final DeleteActivityRepo deleteActivityRepo;

  DeleteActivityCubit({required this.deleteActivityRepo})
      : super(DeleteActivityInitial());

  Future<void> deleteActivity(int id) async {
    emit(DeleteActivityLoading(id));

    final result = await deleteActivityRepo.deleteActivity(id: id);

    if (result.status=='success') {
      emit(DeleteActivitySuccess(result));
    } else {
      emit(DeleteActivityFailure(result));
    }
  }

}
