import 'package:equatable/equatable.dart';
import 'package:fayoum_club_management/core/data/models/success_model.dart';

abstract class DeleteUserState extends Equatable {
  const DeleteUserState();

  @override
  List<Object?> get props => [];
}

class DeleteUserInitial extends DeleteUserState {}

class DeleteUserLoading extends DeleteUserState {
  final int userId;

  const DeleteUserLoading(this.userId);

  @override
  List<Object?> get props => [userId];
}

class DeleteUserSuccess extends DeleteUserState {
  final SuccessModel model;

  const DeleteUserSuccess(this.model);

  @override
  List<Object?> get props => [model];
}

class DeleteUserFailure extends DeleteUserState {
  final SuccessModel error;

  const DeleteUserFailure(this.error);

  @override
  List<Object?> get props => [error];
}
