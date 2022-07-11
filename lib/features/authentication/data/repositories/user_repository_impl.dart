import 'package:dartz/dartz.dart';
import '../../domain/entities/user.dart';

import '../../../../../core/errors/exception.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/network/network_info.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_remote_datasource.dart';
import '../models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  UserRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  var currentUser = UserModel.empty;

  @override
  Future<Either<Failure, UserModel>> registerUser(
      {required String phone, required String password}) async {
    if (await networkInfo.isConnected) {
      try {
        final userDetails = await remoteDataSource.registerUser(
          phone: phone,
          password: password,
        );
        return Right(userDetails);
      } on ServerFailure catch (e) {
        return Left(e);
      }
    } else {
      return Left(CacheFailure(properties: []));
    }
  }

  @override
  Future<Either<Failure, int?>> sendOTPToPhone(String phone) async {
    if (await networkInfo.isConnected) {
      try {
        final otp = await remoteDataSource.sendOTPToPhone(phone);
        // perform caching only when it gets things from server successfully
        return Right(otp);
      } on ServerException {
        return Left(ServerFailure(properties: []));
      }
    } else {
      return Left(CacheFailure(properties: []));
    }
  }

  @override
  Future<Either<Failure, User>> loginUser(
      {required String phone, required String password}) async {

    if (await networkInfo.isConnected) {
      try {
        final userDetails =
            await remoteDataSource.loginUser(phone: phone, password: password);
        currentUser = userDetails;
        // perform caching only when it gets things from server successfully
        print("CurrentUserDetails$currentUser");
        return Right(userDetails);
      } on ServerFailure catch (e) {
        return Left(e);
      }
    } else {
      return Left(CacheFailure(properties: []));
    }
  }

  @override
  Future<Either<Failure, UserModel>> refreshCurrentUser(
      {required String uid}) async {
    if (await networkInfo.isConnected) {
      try {
        final userDetails = await remoteDataSource.refreshCurrentUser(uid: uid);
        currentUser = userDetails;
        // perform caching only when it gets things from server successfully
        return Right(userDetails);
      } on ServerFailure catch (e) {
        return Left(e);
      }
    } else {
      throw Left(CacheFailure(properties: []));
    }
  }

  @override
  Future<Either<Failure, UserModel>> switchUser(
      {required String uid, required String activeRole}) async {
    if (await networkInfo.isConnected) {
      try {
        final userDetails =
            await remoteDataSource.switchUser(uid: uid, activeRole: activeRole);
        // perform caching only when it gets things from server successfully
        return Right(userDetails);
      } on ServerFailure catch (e) {
        throw Left(e);
      }
    } else {
      throw Left(CacheFailure(properties: []));
    }
  }

  @override
  Future<void>? logout(String uid) {
    // TODO: implement logout
    throw UnimplementedError();
  }
}
