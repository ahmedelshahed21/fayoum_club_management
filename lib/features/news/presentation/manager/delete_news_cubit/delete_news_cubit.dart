import 'package:fayoum_club_management/features/news/data/repos/delete_news_repo/delete_news_repo.dart';
import 'package:fayoum_club_management/features/news/presentation/manager/delete_news_cubit/delete_news_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteNewsCubit extends Cubit<DeleteNewsState> {
  final DeleteNewsRepo deleteNewsRepo;

  DeleteNewsCubit({required this.deleteNewsRepo})
      : super(DeleteNewsInitial());

  Future<void> deleteNews({required int id}) async {
    emit(DeleteNewsLoading(id));

    final result = await deleteNewsRepo.deleteNews(id: id);

    if (result.status=='success') {
      emit(DeleteNewsSuccess(result));
    } else {
      emit(DeleteNewsFailure(result));
    }
  }

}
