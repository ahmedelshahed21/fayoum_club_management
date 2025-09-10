import '../../../../../core/data/models/success_model.dart';

abstract class DeleteInquiryRepo {
  Future<SuccessModel> deleteInquiry({required int id});
}
