import 'package:equatable/equatable.dart';
import 'package:fayoum_club_management/core/data/models/success_model.dart';

abstract class DeleteTrainerState extends Equatable {
  const DeleteTrainerState();

  @override
  List<Object?> get props => [];
}

class DeleteTrainerInitial extends DeleteTrainerState {}

class DeleteTrainerLoading extends DeleteTrainerState {
  final int trainerId;

  const DeleteTrainerLoading(this.trainerId);

  @override
  List<Object?> get props => [trainerId];
}

class DeleteTrainerSuccess extends DeleteTrainerState {
  final SuccessModel model;

  const DeleteTrainerSuccess(this.model);

  @override
  List<Object?> get props => [model];
}

class DeleteTrainerFailure extends DeleteTrainerState {
  final SuccessModel error;

  const DeleteTrainerFailure(this.error);

  @override
  List<Object?> get props => [error];
}
