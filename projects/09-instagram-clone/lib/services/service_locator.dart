import 'package:get_it/get_it.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

// Features - Auth
import '../features/auth/data/datasources/auth_remote_datasource.dart';
import '../features/auth/data/repositories/auth_repository_impl.dart';
import '../features/auth/domain/repositories/auth_repository.dart';
import '../features/auth/domain/usecases/sign_in_usecase.dart';
import '../features/auth/domain/usecases/sign_up_usecase.dart';
import '../features/auth/domain/usecases/sign_out_usecase.dart';
import '../features/auth/domain/usecases/get_current_user_usecase.dart';
import '../features/auth/presentation/bloc/auth_bloc.dart';

// Features - Feed
import '../features/feed/data/datasources/feed_remote_datasource.dart';
import '../features/feed/data/repositories/feed_repository_impl.dart';
import '../features/feed/domain/repositories/feed_repository.dart';
import '../features/feed/domain/usecases/get_feed_posts_usecase.dart';
import '../features/feed/domain/usecases/like_post_usecase.dart';
import '../features/feed/domain/usecases/add_comment_usecase.dart';
import '../features/feed/presentation/bloc/feed_bloc.dart';

// Features - Profile
import '../features/profile/data/datasources/profile_remote_datasource.dart';
import '../features/profile/data/repositories/profile_repository_impl.dart';
import '../features/profile/domain/repositories/profile_repository.dart';
import '../features/profile/domain/usecases/get_user_profile_usecase.dart';
import '../features/profile/domain/usecases/update_profile_usecase.dart';
import '../features/profile/domain/usecases/follow_user_usecase.dart';
import '../features/profile/domain/usecases/unfollow_user_usecase.dart';
import '../features/profile/presentation/bloc/profile_bloc.dart';

// Features - Upload
import '../features/upload/data/datasources/upload_remote_datasource.dart';
import '../features/upload/data/repositories/upload_repository_impl.dart';
import '../features/upload/domain/repositories/upload_repository.dart';
import '../features/upload/domain/usecases/upload_post_usecase.dart';
import '../features/upload/presentation/bloc/upload_bloc.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // External dependencies
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getIt.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  getIt.registerLazySingleton<FirebaseStorage>(() => FirebaseStorage.instance);

  // Auth feature
  _setupAuthFeature();

  // Feed feature
  _setupFeedFeature();

  // Profile feature
  _setupProfileFeature();

  // Upload feature
  _setupUploadFeature();
}

void _setupAuthFeature() {
  // Data sources
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      firebaseAuth: getIt(),
      firestore: getIt(),
    ),
  );

  // Repositories
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: getIt()),
  );

  // Use cases
  getIt.registerLazySingleton(() => SignInUseCase(getIt()));
  getIt.registerLazySingleton(() => SignUpUseCase(getIt()));
  getIt.registerLazySingleton(() => SignOutUseCase(getIt()));
  getIt.registerLazySingleton(() => GetCurrentUserUseCase(getIt()));

  // BLoC
  getIt.registerFactory(
    () => AuthBloc(
      signInUseCase: getIt(),
      signUpUseCase: getIt(),
      signOutUseCase: getIt(),
      getCurrentUserUseCase: getIt(),
    ),
  );
}

void _setupFeedFeature() {
  // Data sources
  getIt.registerLazySingleton<FeedRemoteDataSource>(
    () => FeedRemoteDataSourceImpl(
      firestore: getIt(),
      firebaseAuth: getIt(),
    ),
  );

  // Repositories
  getIt.registerLazySingleton<FeedRepository>(
    () => FeedRepositoryImpl(remoteDataSource: getIt()),
  );

  // Use cases
  getIt.registerLazySingleton(() => GetFeedPostsUseCase(getIt()));
  getIt.registerLazySingleton(() => LikePostUseCase(getIt()));
  getIt.registerLazySingleton(() => AddCommentUseCase(getIt()));

  // BLoC
  getIt.registerFactory(
    () => FeedBloc(
      getFeedPostsUseCase: getIt(),
      likePostUseCase: getIt(),
      addCommentUseCase: getIt(),
    ),
  );
}

void _setupProfileFeature() {
  // Data sources
  getIt.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(
      firestore: getIt(),
      firebaseAuth: getIt(),
      firebaseStorage: getIt(),
    ),
  );

  // Repositories
  getIt.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(remoteDataSource: getIt()),
  );

  // Use cases
  getIt.registerLazySingleton(() => GetUserProfileUseCase(getIt()));
  getIt.registerLazySingleton(() => UpdateProfileUseCase(getIt()));
  getIt.registerLazySingleton(() => FollowUserUseCase(getIt()));
  getIt.registerLazySingleton(() => UnfollowUserUseCase(getIt()));

  // BLoC
  getIt.registerFactory(
    () => ProfileBloc(
      getUserProfileUseCase: getIt(),
      updateProfileUseCase: getIt(),
      followUserUseCase: getIt(),
      unfollowUserUseCase: getIt(),
    ),
  );
}

void _setupUploadFeature() {
  // Data sources
  getIt.registerLazySingleton<UploadRemoteDataSource>(
    () => UploadRemoteDataSourceImpl(
      firestore: getIt(),
      firebaseStorage: getIt(),
      firebaseAuth: getIt(),
    ),
  );

  // Repositories
  getIt.registerLazySingleton<UploadRepository>(
    () => UploadRepositoryImpl(remoteDataSource: getIt()),
  );

  // Use cases
  getIt.registerLazySingleton(() => UploadPostUseCase(getIt()));

  // BLoC
  getIt.registerFactory(
    () => UploadBloc(uploadPostUseCase: getIt()),
  );
}
