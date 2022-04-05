
import 'package:get_it/get_it.dart';


import '../../data/repository/user_auth_repository.dart';
import '../../data/repository/user_db_repository.dart';
import '../../data/repository/user_storage_repository.dart';
import '../../data/service/auth/fake_auth_service.dart';
import '../../data/service/auth/firebase_auth_service.dart';
import '../../data/service/db/firestore_db_service.dart';
import '../../data/service/storage/firebase_storage_service.dart';

GetIt locator = GetIt.instance;

void setupLocator(){
  //Services
  locator.registerLazySingleton(() => FirebaseAuthService());
  locator.registerLazySingleton(() => FakeAuthService());
  locator.registerLazySingleton(() => FireStoreDbService());
  locator.registerLazySingleton(() => FireBaseStorageService());
  //Repository
  locator.registerLazySingleton(() => UserAuthRepository());
  locator.registerLazySingleton(() => UserDbRepository());
  locator.registerLazySingleton(() => UserStorageRepository());
}