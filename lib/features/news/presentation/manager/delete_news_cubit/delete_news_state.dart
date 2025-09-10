import 'package:equatable/equatable.dart';
import 'package:fayoum_club_management/core/data/models/success_model.dart';

abstract class DeleteNewsState extends Equatable {
  const DeleteNewsState();

  @override
  List<Object?> get props => [];
}

class DeleteNewsInitial extends DeleteNewsState {}

class DeleteNewsLoading extends DeleteNewsState {
  final int activityId;

  const DeleteNewsLoading(this.activityId);

  @override
  List<Object?> get props => [activityId];
}

class DeleteNewsSuccess extends DeleteNewsState {
  final SuccessModel model;

  const DeleteNewsSuccess(this.model);

  @override
  List<Object?> get props => [model];
}

class DeleteNewsFailure extends DeleteNewsState {
  final SuccessModel error;

  const DeleteNewsFailure(this.error);

  @override
  List<Object?> get props => [error];
}
