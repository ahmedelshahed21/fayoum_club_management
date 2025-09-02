import 'package:equatable/equatable.dart';
import 'package:fayoum_club_management/core/data/models/basic_model.dart';

abstract class DeleteActivityState extends Equatable {
  const DeleteActivityState();

  @override
  List<Object?> get props => [];
}

class DeleteActivityInitial extends DeleteActivityState {}

class DeleteActivityLoading extends DeleteActivityState {
  final int activityId;

  const DeleteActivityLoading(this.activityId);

  @override
  List<Object?> get props => [activityId];
}

class DeleteActivitySuccess extends DeleteActivityState {
  final BasicModel model;

  const DeleteActivitySuccess(this.model);

  @override
  List<Object?> get props => [model];
}

class DeleteActivityFailure extends DeleteActivityState {
  final BasicModel error;

  const DeleteActivityFailure(this.error);

  @override
  List<Object?> get props => [error];
}
