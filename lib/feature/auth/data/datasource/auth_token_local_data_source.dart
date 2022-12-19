import 'package:hive/hive.dart';
import 'package:the_24_hour/feature/auth/data/model/auth_token_model.dart';
import 'package:the_24_hour/product/constant/hive_constants.dart';
import 'package:the_24_hour/product/error/exception.dart';

abstract class AuthTokenLocalDataSource {
  /// Gets the cached `AuthTokenModel`.
  ///
  /// Throws `NullBoxModelException` if the key does not exist.
  Future<AuthTokenModel> getAuthToken();
  Future<void> cacheAuthToken(AuthTokenModel modelToCache);
}

class AuthTokenLocalDataSourceImpl implements AuthTokenLocalDataSource {
  const AuthTokenLocalDataSourceImpl(this.hive);

  final HiveInterface hive;

  @override
  Future<void> cacheAuthToken(AuthTokenModel modelToCache) async {
    _ensureAdaptersRegistered();
    final box = await hive.openBox<AuthTokenModel>(HiveConstants.authTokenModelKey);
    await box.put(HiveConstants.authTokenModelTypeId, modelToCache);
  }

  @override
  Future<AuthTokenModel> getAuthToken() async {
    _ensureAdaptersRegistered();
    final box = await hive.openBox<AuthTokenModel>(HiveConstants.authTokenModelKey);
    final authTokenModel = box.get(HiveConstants.authTokenModelTypeId);
    return authTokenModel ?? (throw NullBoxModelException());
  }

  void _ensureAdaptersRegistered() {
    if (!hive.isAdapterRegistered(HiveConstants.authTokenModelTypeId)) {
      hive.registerAdapter<AuthTokenModel>(AuthTokenModelAdapter());
    }
  }
}
