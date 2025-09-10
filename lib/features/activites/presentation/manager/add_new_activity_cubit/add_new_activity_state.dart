import 'package:equatable/equatable.dart';
import 'package:fayoum_club_management/core/data/models/success_model.dart';
import 'package:fayoum_club_management/core/data/models/validation_model.dart';

abstract class AddNewActivityState extends Equatable {
  const AddNewActivityState();

  @override
  List<Object?> get props => [];
}

class AddNewActivityInitial extends AddNewActivityState {}

class AddNewActivityLoading extends AddNewActivityState {
  const AddNewActivityLoading();

  @override
  List<Object?> get props => [];
}

class AddNewActivitySuccess extends AddNewActivityState {
  final SuccessModel model;

  const AddNewActivitySuccess(this.model);

  @override
  List<Object?> get props => [model];
}

class AddNewActivityFailure extends AddNewActivityState {
  final ValidationModel failure;

  const AddNewActivityFailure(this.failure);

  @override
  List<Object?> get props => [failure];
}
