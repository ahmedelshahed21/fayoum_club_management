import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:fayoum_club_management/core/data/models/auth_failure_model.dart';
import 'package:fayoum_club_management/core/data/models/basic_model.dart';
import 'package:fayoum_club_management/features/news/data/models/add_new_news_request_model/add_new_news_request_model.dart';
import 'package:fayoum_club_management/features/news/data/repos/add_new_news_repo/add_new_news_repo.dart';
import 'package:fayoum_club_management/features/news/presentation/manager/add_new_news_cubit/add_new_news_state.dart';

class AddNewNewsCubit extends Cubit<AddNewNewsState> {
  final AddNewNewsRepo addNewNewsRepo;

  AddNewNewsCubit({required this.addNewNewsRepo})
      : super(AddNewNewsInitial());

  Future<void> addNewNews({
    required AddNewNewsRequestModel requestModel,
    File? image,
  }) async {
    emit(const AddNewNewsLoading());

    final Either<AuthFailureModel, BasicModel> result =
    await addNewNewsRepo.addNewNews(
      requestModel: requestModel,
      image: image,
    );

    result.fold(
          (failure) => emit(AddNewNewsFailure(failure)),
          (success) => emit(AddNewNewsSuccess(success)),
    );
  }
}
