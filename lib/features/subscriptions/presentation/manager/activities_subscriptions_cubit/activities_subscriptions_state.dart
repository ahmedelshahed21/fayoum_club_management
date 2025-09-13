import 'package:equatable/equatable.dart';
import 'package:fayoum_club_management/features/subscriptions/data/models/activities_subscriptions_model/activities_subscriptions_model.dart';

abstract class ActivitiesSubscriptionsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ActivitiesSubscriptionsInitial extends ActivitiesSubscriptionsState {}

class ActivitiesSubscriptionsLoading extends ActivitiesSubscriptionsState {}

class ActivitiesSubscriptionsLoaded extends ActivitiesSubscriptionsState {
  final List<ActivitySubscriptionItem> items;
  final bool hasMore;

  ActivitiesSubscriptionsLoaded({
    required this.items,
    required this.hasMore,
  });

  @override
  List<Object?> get props => [items, hasMore];
}

class ActivitiesSubscriptionsError extends ActivitiesSubscriptionsState {
  final String message;

  ActivitiesSubscriptionsError(this.message);

  @override
  List<Object?> get props => [message];
}
