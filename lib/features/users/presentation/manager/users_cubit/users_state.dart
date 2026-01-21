import 'package:fayoum_club_management/features/users/data/models/users_model/users_model.dart';

abstract class UsersState {}

class UsersInitial extends UsersState {}

class UsersLoading extends UsersState {}

class UsersLoaded extends UsersState {
  final List<UserItem> items;
  final bool hasMore;
  final int total;

  UsersLoaded({
    required this.items,
    required this.hasMore,
    required this.total,
  });
}

class UsersError extends UsersState {
  final String message;

  UsersError(this.message);
}
