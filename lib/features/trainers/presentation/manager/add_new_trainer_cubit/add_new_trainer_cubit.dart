import 'dart:io';
import 'package:fayoum_club_management/features/trainers/data/models/add_new_trainer_request_model.dart';
import 'package:fayoum_club_management/features/trainers/data/repos/add_new_trainer_repo/add_new_trainer_repo.dart';
import 'package:fayoum_club_management/features/trainers/presentation/manager/add_new_trainer_cubit/add_new_trainer_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:fayoum_club_management/core/data/models/validation_model.dart';
import 'package:fayoum_club_management/core/data/models/basic_model.dart';

class AddNewTrainerCubit extends Cubit<AddNewTrainerState> {
  final AddNewTrainerRepo addNewTrainerRepo;

  AddNewTrainerCubit({required this.addNewTrainerRepo})
    : super(AddNewTrainerInitial());

  Future<void> addNewTrainer({
    required AddNewTrainerRequestModel requestModel,
    File? image,
  }) async {
    emit(const AddNewTrainerLoading());

    final Either<ValidationModel, BasicModel> result = await addNewTrainerRepo
        .addNewTrainer(requestModel: requestModel, image: image);

    result.fold(
      (failure) => emit(AddNewTrainerFailure(failure)),
      (success) => emit(AddNewTrainerSuccess(success)),
    );
  }
}
