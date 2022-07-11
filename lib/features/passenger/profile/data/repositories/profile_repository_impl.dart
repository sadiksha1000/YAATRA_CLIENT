import 'package:dartz/dartz.dart';
import 'package:yaatra_client/features/authentication/data/models/user_model.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/network/network_info.dart';
import '../../domain/enities/passenger_profile.dart';
import '../../domain/repositories/passenger_profile_repositories.dart';
import '../datasources/passenger_profile_remote_datasourse.dart';
import '../models/passenger_profile_model.dart';

class PassengerProfileRepositoryImpl implements PassengerProfileRepository {
  final PassengerProfileRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  PassengerProfileRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, PassengerProfile>> createProfile(
      PassengerProfile passengerProfile) async {
    if (await networkInfo.isConnected) {
      try {
        final userDetails =
            await remoteDataSource.createProfile(passengerProfile);
        return Right(userDetails);
      } on ServerFailure catch (e) {
        return Left(e);
      }
    } else {
      return Left(CacheFailure(properties: []));
    }
  }

  @override
  Future<Either<Failure, PassengerProfile>> getCurrentPassenger(
      {required String uid}) async {
    if (await networkInfo.isConnected) {
      try {
        final passengerDetails =
            await remoteDataSource.getCurrentPassenger(uid: uid);
        print("Here at get current passenger");
        print("PassengerDetails${passengerDetails}");
        return Right(passengerDetails);
      } on ServerFailure catch (e) {
        return Left(e);
      }
    } else {
      print("Repo failed");
      return Left(CacheFailure(properties: []));
    }
  }

  @override
  Future<Either<Failure, List<PassengerProfile>>> fetchAllPassenger() {
    throw UnimplementedError();
  }
}
