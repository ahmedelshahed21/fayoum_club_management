import 'package:dartz/dartz.dart';
import 'package:fayoum_club_management/core/errors/failure.dart';
import 'package:fayoum_club_management/features/activites/data/models/activity_details_model/activity_details_model.dart';
import 'package:fayoum_club_management/features/activites/data/repos/activity_details_repo/activity_details_repo.dart';
import 'package:fayoum_club_management/features/activites/presentation/manager/activity_details_cubit/activity_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActivityDetailsCubit extends Cubit<ActivityDetailsState> {
  final ActivityDetailsRepo activityDetailsRepo;

  ActivityDetailsCubit({required this.activityDetailsRepo})
    : super(const ActivityDetailsInitial());

  Future<void> getActivityDetails({required int activityId}) async {
    emit(const ActivityDetailsLoading());

    final Either<Failure, ActivityDetailsModel> result =
        await activityDetailsRepo.getActivityDetails(activityId: activityId);

    result.fold(
      (failure) => emit(ActivityDetailsFailure(failure)),
      (detailsModel) => emit(ActivityDetailsSuccess(detailsModel)),
    );
  }
}
