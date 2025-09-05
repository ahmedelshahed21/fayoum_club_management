import 'package:fayoum_club_management/features/inquiries/data/models/inquiries_model.dart';

abstract class InquiriesState {}

class InquiriesInitial extends InquiriesState {}

class InquiriesLoading extends InquiriesState {}

class InquiriesLoaded extends InquiriesState {
  final List<InquiryItem> items;
  final bool hasMore;

  InquiriesLoaded({
    required this.items,
    required this.hasMore,
  });
}

class InquiriesError extends InquiriesState {
  final String message;

  InquiriesError(this.message);
}
