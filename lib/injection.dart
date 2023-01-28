// ignore_for_file: cascade_invocations

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:the_24_hour/feature/auth/data/datasource/auth_token_local_data_source.dart';
import 'package:the_24_hour/feature/auth/data/datasource/auth_token_remote_data_source.dart';
import 'package:the_24_hour/feature/auth/data/datasource/reset_password_service.dart';
import 'package:the_24_hour/feature/auth/data/model/auth_token_model.dart';
import 'package:the_24_hour/feature/auth/data/repository/login_repository_impl.dart';
import 'package:the_24_hour/feature/auth/data/repository/reset_password_repository_impl.dart';
import 'package:the_24_hour/feature/auth/data/repository/sign_up_repository_impl.dart';
import 'package:the_24_hour/feature/auth/domain/repository/login_repository.dart';
import 'package:the_24_hour/feature/auth/domain/repository/reset_password_repository.dart';
import 'package:the_24_hour/feature/auth/domain/repository/sign_up_repository.dart';
import 'package:the_24_hour/feature/auth/domain/usecase/login_with_email_and_password.dart';
import 'package:the_24_hour/feature/auth/domain/usecase/reset_password.dart';
import 'package:the_24_hour/feature/auth/domain/usecase/sign_up.dart';
import 'package:the_24_hour/feature/auth/presentation/cubit/login_cubit.dart';
import 'package:the_24_hour/feature/auth/presentation/cubit/reset_password_cubit.dart';
import 'package:the_24_hour/feature/auth/presentation/cubit/sign_up_cubit.dart';
import 'package:the_24_hour/product/constant/hive_constants.dart';
import 'package:the_24_hour/product/navigation/app_router.dart';

final sl = GetIt.instance;

Future<void> setup() async {
  // Feature - Auth

  // Bloc
  sl.registerFactory<LoginCubit>(
    () => LoginCubit(loginNormal: sl()),
  );
  sl.registerFactory<SignUpCubit>(
    () => SignUpCubit(signUp: sl()),
  );
  sl.registerFactory<ResetPasswordCubit>(
    () => ResetPasswordCubit(sl()),
  );
  // Use case
  sl.registerLazySingleton<LoginWithEmailAndPassword>(
    () => LoginWithEmailAndPassword(sl()),
  );
  sl.registerLazySingleton<SignUp>(
    () => SignUp(sl()),
  );
  sl.registerLazySingleton<ResetPassword>(
    () => ResetPassword(sl()),
  );
  // Repository
  sl.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(
      localDataSource: sl(),
      remoteDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<SignUpRepository>(
    () => SignUpRepositoryImpl(
      localDataSource: sl(),
      remoteDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<ResetPasswordRepository>(
    () => ResetPasswordRepositoryImpl(sl()),
  );
  // Data sources and Service
  sl.registerLazySingleton<AuthTokenLocalDataSource>(
    () => AuthTokenLocalDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<AuthTokenRemoteDataSource>(
    () => AuthTokenRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<ResetPasswordService>(
    () => ResetPasswordServiceImpl(sl()),
  );

  // External
  await Hive.initFlutter(HiveConstants.fileName);
  Hive.registerAdapter<AuthTokenModel>(AuthTokenModelAdapter());
  await Hive.openBox<AuthTokenModel>(HiveConstants.authTokenModelKey);

  sl.registerLazySingleton<AppRouter>(AppRouter.new);

  sl.registerLazySingleton<HiveInterface>(() => Hive);
  sl.registerLazySingleton<http.Client>(http.Client.new);
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
}
