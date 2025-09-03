import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:fayoum_club_management/core/data/models/basic_model.dart';
import 'package:fayoum_club_management/core/data/models/validation_model.dart';
import 'package:fayoum_club_management/features/activites/data/models/add_new_activity_model/add_new_activity_request_model.dart';
import 'package:fayoum_club_management/features/activites/data/repos/add_new_activity_repo/add_new_activity_repo.dart';
import 'package:fayoum_club_management/features/activites/presentation/manager/add_new_activity_cubit/add_new_activity_state.dart';

class AddNewActivityCubit extends Cubit<AddNewActivityState> {
  final AddNewActivityRepo addNewActivityRepo;

  AddNewActivityCubit({required this.addNewActivityRepo})
    : super(AddNewActivityInitial());

  Future<void> addNewActivity({
    required AddNewActivityRequestModel requestModel,
    File? image,
  }) async {
    emit(const AddNewActivityLoading());

    final Either<ValidationModel, BasicModel> result = await addNewActivityRepo
        .addNewActivity(requestModel: requestModel, image: image);

    result.fold(
      (failure) => emit(AddNewActivityFailure(failure)),
      (success) => emit(AddNewActivitySuccess(success)),
    );
  }
}
