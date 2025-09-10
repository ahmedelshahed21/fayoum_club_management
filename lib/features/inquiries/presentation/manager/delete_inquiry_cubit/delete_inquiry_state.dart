import 'package:equatable/equatable.dart';
import 'package:fayoum_club_management/core/data/models/success_model.dart';

abstract class DeleteInquiryState extends Equatable {
  const DeleteInquiryState();

  @override
  List<Object?> get props => [];
}

class DeleteInquiryInitial extends DeleteInquiryState {}

class DeleteInquiryLoading extends DeleteInquiryState {
  final int inquiryId;

  const DeleteInquiryLoading(this.inquiryId);

  @override
  List<Object?> get props => [inquiryId];
}

class DeleteInquirySuccess extends DeleteInquiryState {
  final SuccessModel model;

  const DeleteInquirySuccess(this.model);

  @override
  List<Object?> get props => [model];
}

class DeleteInquiryFailure extends DeleteInquiryState {
  final SuccessModel error;

  const DeleteInquiryFailure(this.error);

  @override
  List<Object?> get props => [error];
}
