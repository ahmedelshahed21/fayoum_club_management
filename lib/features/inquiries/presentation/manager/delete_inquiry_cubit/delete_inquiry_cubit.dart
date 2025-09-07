import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fayoum_club_management/features/inquiries/data/repos/delete_inquiry_repo/delete_inquiry_repo.dart';
import 'delete_inquiry_state.dart';

class DeleteInquiryCubit extends Cubit<DeleteInquiryState> {
  final DeleteInquiryRepo deleteInquiryRepo;

  DeleteInquiryCubit({required this.deleteInquiryRepo})
      : super(DeleteInquiryInitial());

  Future<void> deleteInquiry(int id) async {
    emit(DeleteInquiryLoading(id));

    final result = await deleteInquiryRepo.deleteInquiry(id: id);

    if (result.status == 'success') {
      emit(DeleteInquirySuccess(result));
    } else {
      emit(DeleteInquiryFailure(result));
    }
  }
}
