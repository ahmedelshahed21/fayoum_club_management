import 'package:fayoum_club_management/features/activites/data/models/activity_details_model/activity_details_model.dart';
import 'package:fayoum_club_management/features/activites/presentation/views/activity_details_view.dart';
import 'package:fayoum_club_management/features/activites/presentation/views/add_new_activity_view.dart';
import 'package:fayoum_club_management/features/activites/presentation/views/trainer_view.dart';
import 'package:fayoum_club_management/features/more/presentation/views/contact_us_view.dart';
import 'package:fayoum_club_management/features/news/data/models/news_model.dart';
import 'package:fayoum_club_management/features/home/presentation/views/home_page.dart';
import 'package:fayoum_club_management/features/home/presentation/views/news_details_view.dart';
import 'package:fayoum_club_management/features/news/presentation/views/add_new_news_view.dart';
import 'package:fayoum_club_management/features/profile/presentation/view/profile_view.dart';
import 'package:go_router/go_router.dart';
import '../../features/login/presentation/views/login_view.dart';
import '../../features/splash/presentation/views/splash_view.dart';

abstract class AppRouter {
  static const welcomeView = '/welcomeView';
  static const loginView = '/loginView';
  static const registerView = '/registerView';
  static const homePage = '/homePage';
  static const addNewActivityView = '/addNewActivityView';
  static const activityDetailsView = '/activityDetailsView';
  static const trainerView = '/trainerView';
  static const addNewNewsView = '/addNewNewsView';
  static const newsDetailsView = '/newsDetailsView';

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
      GoRoute(path: addNewActivityView, builder: (context, state) => const AddNewActivityView()),

      GoRoute(
        path: newsDetailsView,
        builder: (context, state) {
          final NewsItem news = state.extra as NewsItem;
          return NewsDetailsView(news: news);
        },
      ),
      GoRoute(
        path: activityDetailsView,
        builder: (context, state) {
          final int id = state.extra as int;
          return ActivityDetailsView(id: id);
        },
      ),
      GoRoute(
        path: trainerView,
        builder: (context, state) {
          final CaptainModel trainer = state.extra as CaptainModel;
          return TrainerView(trainer: trainer);
        },
      ),
      GoRoute(
        path: addNewNewsView,
        builder: (context, state) => const AddNewNewsView(),
      ),
      // GoRoute(
      //   path: payMobView,
      //   builder: (context, state) {
      //     final ActivityDetailsData activityDetailsData =
      //         state.extra as ActivityDetailsData;
      //     return PayMobView(activityDetailsData: activityDetailsData);
      //   },
      // ),
      // GoRoute(
      //   path: payMobView,
      //   builder: (context, state) {
      //     final data = state.extra as Map<String, dynamic>;
      //     return PayMobView(
      //       activityDetailsData: data['activityDetailsData'],
      //       transactionId: data['transactionId'],
      //       residenceBookingInvoiceData: data['residenceBookingInvoiceData'],
      //
      //     );
      //   },
      // ),
      GoRoute(
        path: profileView,
        builder: (context, state) => const ProfileView(),
      ),
      GoRoute(
        path: contactUsView,
        builder: (context, state) => const ContactUsView(),
      ),
    ],
  );
}
