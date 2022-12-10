import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:the_24_hour/feature/auth/data/datasource/auth_token_local_data_source.dart';
import 'package:the_24_hour/feature/auth/data/model/auth_token_model.dart';
import 'package:the_24_hour/product/constant/hive_constants.dart';
import 'package:the_24_hour/product/error/exception.dart';

@GenerateNiceMocks([
  MockSpec<HiveInterface>(),
  MockSpec<Box<AuthTokenModel>>(),
])
import 'auth_token_local_data_source_test.mocks.dart';

void main() {
  late AuthTokenLocalDataSourceImpl sut;
  late MockHiveInterface mockHive;
  late MockBox mockBox;

  setUp(() {
    mockHive = MockHiveInterface();
    mockBox = MockBox();
    sut = AuthTokenLocalDataSourceImpl(mockHive);
  });

  group('getAuthToken -', () {
    const tAuthTokenModel = AuthTokenModel(
      localId: 'test localId',
      email: 'test email',
      idToken: 'test idToken',
      refreshToken: 'test refreshToken',
      expiresIn: 3600,
    );

    void openBox() {
      when(mockHive.openBox<AuthTokenModel>(HiveConstants.authTokenModelKey)).thenAnswer(
        (_) async => mockBox,
      );
    }

    test(
      'should return AuthToken from Hive Box when there is one in the and the box is opened',
      () async {
        // arrange
        openBox();
        when(mockHive.isAdapterRegistered(HiveConstants.authTokenModelTypeId)).thenReturn(true);
        when(mockBox.get(HiveConstants.authTokenModelTypeId)).thenReturn(tAuthTokenModel);
        // act
        final result = await sut.getAuthToken();
        // assert
        verify(mockHive.openBox<AuthTokenModel>(HiveConstants.authTokenModelKey)).called(1);
        verify(mockHive.isAdapterRegistered(HiveConstants.authTokenModelTypeId)).called(1);
        verify(mockBox.get(HiveConstants.authTokenModelTypeId)).called(1);
        expect(result, equals(tAuthTokenModel));
      },
    );

    test(
      'should register adapter then return AuthToken when the adapter is not registered',
      () async {
        // arrange
        openBox();
        when(mockHive.isAdapterRegistered(HiveConstants.authTokenModelTypeId)).thenReturn(false);
        when(mockBox.get(HiveConstants.authTokenModelTypeId)).thenReturn(tAuthTokenModel);
        // act
        final result = await sut.getAuthToken();
        // assert
        verify(mockHive.openBox<AuthTokenModel>(HiveConstants.authTokenModelKey)).called(1);
        verify(mockHive.isAdapterRegistered(HiveConstants.authTokenModelTypeId)).called(1);
        verify(mockHive.registerAdapter<AuthTokenModel>(AuthTokenModelAdapter())).called(1);
        verify(mockBox.get(HiveConstants.authTokenModelTypeId)).called(1);
        expect(result, equals(tAuthTokenModel));
      },
    );

    test(
      'should throw ClosedBoxException when there is no box with given key',
      () async {
        // arrange
        openBox();
        when(mockHive.isAdapterRegistered(HiveConstants.authTokenModelTypeId)).thenReturn(true);
        when(mockBox.get(HiveConstants.authTokenModelTypeId)).thenReturn(null);
        // act
        final call = sut.getAuthToken;
        // assert
        expect(call, throwsA(const TypeMatcher<NullBoxModelException>()));
      },
    );
  });

  group('cacheAuthToken -', () {
    const tAuthTokenModel = AuthTokenModel(
      localId: 'test localId',
      email: 'test email',
      idToken: 'test idToken',
      refreshToken: 'test refreshToken',
      expiresIn: 3600,
    );

    void openBox() {
      when(mockHive.openBox<AuthTokenModel>(HiveConstants.authTokenModelKey)).thenAnswer(
        (_) async => mockBox,
      );
    }

    test(
      'should call Hive put method to cache the data',
      () async {
        // arrange
        openBox();
        // act
        await sut.cacheAuthToken(tAuthTokenModel);
        // assert
        verify(mockBox.put(HiveConstants.authTokenModelTypeId, tAuthTokenModel));
      },
    );

    test(
      'should call Hive.registerAdapter then call Hive put method when the adapter is not registered',
      () async {
        // arrange
        openBox();
        when(mockHive.isAdapterRegistered(HiveConstants.authTokenModelTypeId)).thenReturn(false);
        // act
        await sut.cacheAuthToken(tAuthTokenModel);
        // assert
        verify(mockHive.isAdapterRegistered(HiveConstants.authTokenModelTypeId)).called(1);
        verify(mockHive.registerAdapter<AuthTokenModel>(AuthTokenModelAdapter())).called(1);
        verify(mockBox.put(HiveConstants.authTokenModelTypeId, tAuthTokenModel));
      },
    );
  });
}
