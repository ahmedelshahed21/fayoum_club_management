import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fayoum_club_management/features/users/data/repos/users_repo/users_repo.dart';
import 'package:fayoum_club_management/features/users/data/models/users_model/users_model.dart';
import 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  final UsersRepo usersRepo;

  UsersCubit(this.usersRepo) : super(UsersInitial());

  int _currentPage = 1;
  bool _hasMore = true;
  bool _isLoading = false;
  final List<UserItem> _items = [];

  Future<void> fetchUsers({bool refresh = false}) async {
    if (_isLoading) return;


    if (refresh) {
      _currentPage = 1;
      _hasMore = true;
      _items.clear();
    }

    if (!_hasMore) return;

    _isLoading = true;
    if (_currentPage == 1) emit(UsersLoading());

    final result = await usersRepo.getUsers(page: _currentPage);

    result.fold(
          (failure) {
        emit(UsersError(failure.errMessage));
      },
          (data) {
        _items.addAll(data.data.items);
        _hasMore = _currentPage < data.data.pagination.totalPages;

        emit(
          UsersLoaded(
            items: List.from(_items),
            hasMore: _hasMore,
            total: data.data.pagination.total,
          ),
        );

        _currentPage++;
      },
    );

    _isLoading = false;
  }
}
