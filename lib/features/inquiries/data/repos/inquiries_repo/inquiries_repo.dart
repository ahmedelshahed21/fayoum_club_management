import 'package:dartz/dartz.dart';
import 'package:fayoum_club_management/core/errors/failure.dart';
import '../../models/inquiries_model.dart';

abstract class InquiriesRepo {
  Future<Either<Failure, InquiriesModel>> getInquiries({int page = 1});
}
