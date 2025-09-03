import 'package:equatable/equatable.dart';
import 'package:fayoum_club_management/core/data/models/auth_failure_model.dart';
import 'package:fayoum_club_management/core/data/models/basic_model.dart';

abstract class AddNewNewsState extends Equatable {
  const AddNewNewsState();

  @override
  List<Object?> get props => [];
}

class AddNewNewsInitial extends AddNewNewsState {}

class AddNewNewsLoading extends AddNewNewsState {
  const AddNewNewsLoading();

  @override
  List<Object?> get props => [];
}

class AddNewNewsSuccess extends AddNewNewsState {
  final BasicModel model;

  const AddNewNewsSuccess(this.model);

  @override
  List<Object?> get props => [model];
}

class AddNewNewsFailure extends AddNewNewsState {
  final AuthFailureModel failure;

  const AddNewNewsFailure(this.failure);

  @override
  List<Object?> get props => [failure];
}
