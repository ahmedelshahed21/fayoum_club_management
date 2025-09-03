import 'package:equatable/equatable.dart';
import 'package:fayoum_club_management/core/data/models/basic_model.dart';
import 'package:fayoum_club_management/core/data/models/auth_failure_model.dart';

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
  final BasicModel model;

  const AddNewActivitySuccess(this.model);

  @override
  List<Object?> get props => [model];
}

class AddNewActivityFailure extends AddNewActivityState {
  final AuthFailureModel failure;

  const AddNewActivityFailure(this.failure);

  @override
  List<Object?> get props => [failure];
}
