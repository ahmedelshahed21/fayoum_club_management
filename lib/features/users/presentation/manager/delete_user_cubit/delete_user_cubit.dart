import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fayoum_club_management/features/users/data/repos/delete_user_repo/delete_user_repo.dart';
import 'delete_user_state.dart';

class DeleteUserCubit extends Cubit<DeleteUserState> {
  final DeleteUserRepo deleteUserRepo;

  DeleteUserCubit({required this.deleteUserRepo})
      : super(DeleteUserInitial());

  Future<void> deleteUser({required int userId}) async {
    emit(DeleteUserLoading(userId));

    final result = await deleteUserRepo.deleteUser(userId: userId);

    if (result.status == 'success') {
      emit(DeleteUserSuccess(result));
    } else {
      emit(DeleteUserFailure(result));
    }
  }
}
