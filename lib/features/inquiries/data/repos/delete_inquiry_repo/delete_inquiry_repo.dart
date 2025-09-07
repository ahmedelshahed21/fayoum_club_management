import '../../../../../core/data/models/basic_model.dart';

abstract class DeleteInquiryRepo {
  Future<BasicModel> deleteInquiry({required int id});
}
