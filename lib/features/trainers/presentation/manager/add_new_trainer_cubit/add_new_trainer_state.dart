import 'package:equatable/equatable.dart';
import 'package:fayoum_club_management/core/data/models/validation_model.dart';
import 'package:fayoum_club_management/core/data/models/success_model.dart';

abstract class AddNewTrainerState extends Equatable {
  const AddNewTrainerState();

  @override
  List<Object?> get props => [];
}

class AddNewTrainerInitial extends AddNewTrainerState {}

class AddNewTrainerLoading extends AddNewTrainerState {
  const AddNewTrainerLoading();

  @override
  List<Object?> get props => [];
}

class AddNewTrainerSuccess extends AddNewTrainerState {
  final SuccessModel model;

  const AddNewTrainerSuccess(this.model);

  @override
  List<Object?> get props => [model];
}

class AddNewTrainerFailure extends AddNewTrainerState {
  final ValidationModel failure;

  const AddNewTrainerFailure(this.failure);

  @override
  List<Object?> get props => [failure];
}
