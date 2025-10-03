import 'package:fayoum_club_management/features/activites/data/models/activity_details_model/activity_details_model.dart';
import 'package:fayoum_club_management/features/activites/presentation/views/activity_details_view.dart';
import 'package:fayoum_club_management/features/activites/presentation/views/add_new_activity_view.dart';
import 'package:fayoum_club_management/features/subscriptions/presentation/views/activities_subscriptions_view.dart';
import 'package:fayoum_club_management/features/trainers/presentation/views/add_new_trainer_view.dart';
import 'package:fayoum_club_management/features/trainers/presentation/views/trainer_view.dart';
import 'package:fayoum_club_management/features/news/data/models/news_model.dart';
import 'package:fayoum_club_management/features/home/presentation/views/home_page.dart';
import 'package:fayoum_club_management/features/news/presentation/views/news_details_view.dart';
import 'package:fayoum_club_management/features/news/presentation/views/add_new_news_view.dart';
import 'package:fayoum_club_management/features/profile/presentation/view/profile_view.dart';
import 'package:go_router/go_router.dart';
import '../../features/login/presentation/views/login_view.dart';
import '../../features/splash/presentation/views/splash_view.dart';

abstract class AppRouter {
  // static const welcomeView = '/welcomeView';
  static const loginView = '/loginView';
  static const registerView = '/registerView';
  static const homePage = '/homePage';
  static const addNewNewsView = '/addNewNewsView';
  static const newsDetailsView = '/newsDetailsView';
  static const addNewActivityView = '/addNewActivityView';
  static const activityDetailsView = '/activityDetailsView';
  static const addNewTrainerView = '/addNewTrainerView';
  static const trainerDetailsView = '/trainerDetailsView';
  static const activitiesSubscriptionsView = '/activitiesSubscriptionsView';

  static const profileView = '/profileView';
  static const contactUsView = '/contactUsView';

  static final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashView()),
      // GoRoute(
      //   path: welcomeView,
      //   builder: (context, state) => const WelcomeView(),
      // ),
      GoRoute(path: loginView, builder: (context, state) => const LoginView()),
      GoRoute(path: homePage, builder: (context, state) => const HomePage()),
      GoRoute(path: addNewNewsView, builder: (context, state) => const AddNewNewsView()),
      GoRoute(
        path: newsDetailsView,
        builder: (context, state) {
          final NewsItem news = state.extra as NewsItem;
          return NewsDetailsView(news: news);
        },
      ),
      GoRoute(
        path: addNewActivityView,
        builder: (context, state) => const AddNewActivityView(),
      ),
      GoRoute(
        path: activityDetailsView,
        builder: (context, state) {
          final int id = state.extra as int;
          return ActivityDetailsView(id: id);
        },
      ),
      GoRoute(
        path: addNewTrainerView,
        builder: (context, state) {
          final int activityId = state.extra as int;
          return AddNewTrainerView(activityId: activityId);
        },
      ),
      GoRoute(
        path: trainerDetailsView,
        builder: (context, state) {
          final CaptainModel trainer = state.extra as CaptainModel;
          return TrainerView(trainer: trainer);
        },
      ),
      GoRoute(
        path: activitiesSubscriptionsView,
        builder: (context, state) => const ActivitiesSubscriptionsView(),
      ),
      GoRoute(
        path: profileView,
        builder: (context, state) => const ProfileView(),
      ),
      // GoRoute(
      //   path: contactUsView,
      //   builder: (context, state) => const ContactUsView(),
      // ),
    ],
  );
}
