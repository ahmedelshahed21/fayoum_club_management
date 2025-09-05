import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:fayoum_club_management/features/activites/data/repos/activites_repo/activites_repo.dart';
import 'package:fayoum_club_management/features/activites/data/repos/activites_repo/activites_repo_impl.dart';
import 'package:fayoum_club_management/features/activites/data/repos/activity_details_repo/activity_details_repo.dart';
import 'package:fayoum_club_management/features/activites/data/repos/activity_details_repo/activity_details_repo_impl.dart';
import 'package:fayoum_club_management/features/activites/data/repos/add_new_activity_repo/add_new_activity_repo.dart';
import 'package:fayoum_club_management/features/activites/data/repos/add_new_activity_repo/add_new_activity_repo_impl.dart';
import 'package:fayoum_club_management/features/activites/data/repos/delete_activity_repo/delete_activity_repo.dart';
import 'package:fayoum_club_management/features/activites/data/repos/delete_activity_repo/delete_activty_repo_impl.dart';
import 'package:fayoum_club_management/features/activites/presentation/manager/activity_details_cubit/activity_details_cubit.dart';
import 'package:fayoum_club_management/features/activites/presentation/manager/add_new_activity_cubit/add_new_activity_cubit.dart';
import 'package:fayoum_club_management/features/activites/presentation/manager/delete_activity_cubit/delete_activity_cubit.dart';
import 'package:fayoum_club_management/features/home/data/repos/banners_repo/banners_repo.dart';
import 'package:fayoum_club_management/features/home/data/repos/banners_repo/banners_repo_impl.dart';
import 'package:fayoum_club_management/features/activites/presentation/manager/activites_cubit/activites_cubit.dart';
import 'package:fayoum_club_management/features/home/presentation/manager/banners_cubit/banners_cubit.dart';
import 'package:fayoum_club_management/features/inquiries/data/repos/inquiries_repo/inqiries_repo.dart';
import 'package:fayoum_club_management/features/inquiries/data/repos/inquiries_repo/inquiries_repo_impl.dart';
import 'package:fayoum_club_management/features/inquiries/presentation/manager/inquiries_cubit.dart';
import 'package:fayoum_club_management/features/news/data/repos/add_new_news_repo/add_new_news_repo.dart';
import 'package:fayoum_club_management/features/news/data/repos/add_new_news_repo/add_new_news_repo_impl.dart';
import 'package:fayoum_club_management/features/news/data/repos/delete_news_repo/delete_news_repo.dart';
import 'package:fayoum_club_management/features/news/data/repos/delete_news_repo/delete_news_repo_impl.dart';
import 'package:fayoum_club_management/features/news/data/repos/news_repo/news_repo.dart';
import 'package:fayoum_club_management/features/news/data/repos/news_repo/news_repo_impl.dart';
import 'package:fayoum_club_management/features/news/presentation/manager/add_new_news_cubit/add_new_news_cubit.dart';
import 'package:fayoum_club_management/features/news/presentation/manager/delete_news_cubit/delete_news_cubit.dart';
import 'package:fayoum_club_management/features/news/presentation/manager/news_cubit/news_cubit.dart';
import 'package:fayoum_club_management/features/trainers/data/repos/add_new_trainer_repo/add_new_trainer_repo.dart';
import 'package:fayoum_club_management/features/trainers/data/repos/add_new_trainer_repo/add_new_trainer_repo_impl.dart';
import 'package:fayoum_club_management/features/trainers/data/repos/delete_trainer_repo/delete_trainer_repo.dart';
import 'package:fayoum_club_management/features/trainers/data/repos/delete_trainer_repo/delete_trainer_repo_impl.dart';
import 'package:fayoum_club_management/features/trainers/presentation/manager/add_new_trainer_cubit/add_new_trainer_cubit.dart';
import 'package:fayoum_club_management/features/trainers/presentation/manager/delete_trainer_cubit/delete_trainer_cubit.dart';
import 'package:get_it/get_it.dart';
import '../../features/login/data/repos/login_repo_impl.dart';
import '../../features/login/presentation/manager/login_cubit.dart';
import '../databases/api/dio_consumer.dart';
import '../databases/cache/app_data_manager.dart';
import '../databases/cache/cache_helper.dart';
import '../databases/cache/secure_storage_helper.dart';
import '../databases/cache/user_data_manager.dart';
import '../state_management/network_connection_cubit/network_connection_cubit.dart';
import '../state_management/network_connection_cubit/network_info.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  // Core services
  getIt.registerLazySingleton<CacheHelper>(() => CacheHelper());
  getIt.registerSingleton<AppDataManager>(AppDataManager(getIt<CacheHelper>()));
  getIt.registerSingleton<UserDataManager>(
    UserDataManager(getIt<CacheHelper>()),
  );
  getIt.registerLazySingleton<SecureStorageHelper>(() => SecureStorageHelper());
  getIt.registerLazySingleton<DioConsumer>(() => DioConsumer(dio: Dio()));
  getIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(DataConnectionChecker()),
  );
  getIt.registerLazySingleton<NetworkConnectionCubit>(
    () => NetworkConnectionCubit(getIt<NetworkInfo>()),
  );

  // Login dependencies
  getIt.registerSingleton<LoginRepoImpl>(
    LoginRepoImpl(
      dioConsumer: getIt.get<DioConsumer>(),
      secureStorageHelper: getIt<SecureStorageHelper>(),
      userDataManager: getIt<UserDataManager>(),
      networkCubit: getIt<NetworkConnectionCubit>(),
    ),
  );
  getIt.registerFactory<LoginCubit>(
    () => LoginCubit(loginRepo: getIt<LoginRepoImpl>()),
  );

  // Banners dependencies
  getIt.registerLazySingleton<BannersRepo>(
    () => BannersRepoImpl(
      dioConsumer: getIt<DioConsumer>(),
      networkCubit: getIt<NetworkConnectionCubit>(),
    ),
  );
  getIt.registerFactory<BannersCubit>(
    () => BannersCubit(news: getIt<BannersRepo>()),
  );

  // Activites dependencies
  getIt.registerLazySingleton<ActivitesRepo>(
    () => ActivitesRepoImpl(
      dioConsumer: getIt<DioConsumer>(),
      networkCubit: getIt<NetworkConnectionCubit>(),
    ),
  );
  getIt.registerFactory<ActivitesCubit>(
    () => ActivitesCubit(activites: getIt<ActivitesRepo>()),
  );

  // Activity Details dependencies
  getIt.registerLazySingleton<ActivityDetailsRepo>(
    () => ActivityDetailsRepoImpl(
      dioConsumer: getIt<DioConsumer>(),
      networkCubit: getIt<NetworkConnectionCubit>(),
    ),
  );
  getIt.registerFactory<ActivityDetailsCubit>(
    () =>
        ActivityDetailsCubit(activityDetailsRepo: getIt<ActivityDetailsRepo>()),
  );

  // Delete Activity dependencies
  getIt.registerLazySingleton<DeleteActivityRepo>(
    () => DeleteActivityRepoImpl(
      dioConsumer: getIt<DioConsumer>(),
      networkCubit: getIt<NetworkConnectionCubit>(),
      secureStorageHelper: getIt<SecureStorageHelper>(),
    ),
  );
  getIt.registerFactory<DeleteActivityCubit>(
    () => DeleteActivityCubit(deleteActivityRepo: getIt<DeleteActivityRepo>()),
  );

  // Add New Activity dependencies
  getIt.registerLazySingleton<AddNewActivityRepo>(
    () => AddNewActivityRepoImpl(
      dioConsumer: getIt<DioConsumer>(),
      networkCubit: getIt<NetworkConnectionCubit>(),
      secureStorageHelper: getIt<SecureStorageHelper>(),
    ),
  );
  getIt.registerFactory<AddNewActivityCubit>(
    () => AddNewActivityCubit(addNewActivityRepo: getIt<AddNewActivityRepo>()),
  );

  // Delete Trainer dependencies
  getIt.registerLazySingleton<DeleteTrainerRepo>(
    () => DeleteTrainerRepoImpl(
      dioConsumer: getIt<DioConsumer>(),
      networkCubit: getIt<NetworkConnectionCubit>(),
      secureStorageHelper: getIt<SecureStorageHelper>(),
    ),
  );
  getIt.registerFactory<DeleteTrainerCubit>(
    () => DeleteTrainerCubit(deleteTrainerRepo: getIt<DeleteTrainerRepo>()),
  );

  // Add New Trainer dependencies
  getIt.registerLazySingleton<AddNewTrainerRepo>(
    () => AddNewTrainerRepoImpl(
      dioConsumer: getIt<DioConsumer>(),
      networkCubit: getIt<NetworkConnectionCubit>(),
      secureStorageHelper: getIt<SecureStorageHelper>(),
    ),
  );
  getIt.registerFactory<AddNewTrainerCubit>(
    () => AddNewTrainerCubit(addNewTrainerRepo: getIt<AddNewTrainerRepo>()),
  );

  // News dependencies
  getIt.registerLazySingleton<NewsRepo>(
    () => NewsRepoImpl(
      dioConsumer: getIt<DioConsumer>(),
      networkCubit: getIt<NetworkConnectionCubit>(),
    ),
  );
  getIt.registerFactory<NewsCubit>(() => NewsCubit(news: getIt<NewsRepo>()));

  // Delete News dependencies
  getIt.registerLazySingleton<DeleteNewsRepo>(
    () => DeleteNewsRepoImpl(
      dioConsumer: getIt<DioConsumer>(),
      networkCubit: getIt<NetworkConnectionCubit>(),
      secureStorageHelper: getIt<SecureStorageHelper>(),
    ),
  );
  getIt.registerFactory<DeleteNewsCubit>(
    () => DeleteNewsCubit(deleteNewsRepo: getIt<DeleteNewsRepo>()),
  );

  // Add New News dependencies
  getIt.registerLazySingleton<AddNewNewsRepo>(
    () => AddNewNewsRepoImpl(
      dioConsumer: getIt<DioConsumer>(),
      networkCubit: getIt<NetworkConnectionCubit>(),
      secureStorageHelper: getIt<SecureStorageHelper>(),
    ),
  );
  getIt.registerFactory<AddNewNewsCubit>(
    () => AddNewNewsCubit(addNewNewsRepo: getIt<AddNewNewsRepo>()),
  );

  // Inquiries dependencies
  getIt.registerLazySingleton<InquiriesRepo>(
    () => InquiriesRepoImpl(
      dioConsumer: getIt<DioConsumer>(),
      networkCubit: getIt<NetworkConnectionCubit>(),
      secureStorageHelper: getIt<SecureStorageHelper>(),
    ),
  );

  getIt.registerFactory<InquiriesCubit>(
    () => InquiriesCubit(getIt<InquiriesRepo>()),
  );
}
