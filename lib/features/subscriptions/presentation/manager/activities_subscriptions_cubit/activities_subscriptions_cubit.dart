import 'package:fayoum_club_management/features/subscriptions/data/models/activities_subscriptions_model/activities_subscriptions_model.dart';
import 'package:fayoum_club_management/features/subscriptions/data/repos/activities_subscriptions_repo/activities_subscriptions_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'activities_subscriptions_state.dart';

class ActivitiesSubscriptionsCubit extends Cubit<ActivitiesSubscriptionsState> {
  final ActivitiesSubscriptionsRepo repo;

  ActivitiesSubscriptionsCubit(this.repo) : super(ActivitiesSubscriptionsInitial());

  int _currentPage = 1;
  bool _hasMore = true;
  bool _isLoading = false;
  final List<ActivitySubscriptionItem> _items = [];

  Future<void> fetchSubscriptions({bool refresh = false}) async {
    if (_isLoading) return;

    if (refresh) {
      _currentPage = 1;
      _hasMore = true;
      _items.clear();
    }

    if (!_hasMore) return;

    _isLoading = true;
    if (_currentPage == 1) emit(ActivitiesSubscriptionsLoading());

    final result = await repo.getActivitiesSubscriptions(page: _currentPage);

    result.fold(
          (failure) {
        emit(ActivitiesSubscriptionsError(failure.errMessage));
      },
          (data) {
        _items.addAll(data.items);
        _hasMore = _currentPage < (data.pagination?.totalPages ?? 1);

        emit(ActivitiesSubscriptionsLoaded(
          items: List.from(_items),
          hasMore: _hasMore,
        ));

        _currentPage++;
      },
    );

    _isLoading = false;
  }
}
