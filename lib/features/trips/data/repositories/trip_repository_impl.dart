import 'package:dartz/dartz.dart';
import '../models/station_model.dart';
import '../models/trip_model.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/station.dart';
import '../../domain/entities/trip.dart';
import '../../domain/repositories/trip_repository.dart';
import '../datasources/trip_remote_datasource.dart';

class TripRepositoryImpl implements TripRepository {
  final TripRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  TripRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  var currentTrip = Trip.empty;
  var currentStation = Station.empty;

  @override
  Future<Either<Failure, List<TripModel>>> fetchAllTrips({
    required String selectedFromStation,
    required String selectedtoStation,
    required DateTime selectedDate,
    required int seats,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final tripDetails = await remoteDataSource.fetchAllTrips(
          selectedFromStation: selectedFromStation,
          selectedtoStation: selectedtoStation,
          selectedDate: selectedDate,
          seats: seats,
        );
        return Right(tripDetails);
      } on ServerFailure catch (e) {
        return Left(e);
      }
    } else {
      return Left(CacheFailure(properties: []));
    }
  }

  @override
  Future<Either<Failure, List<StationModel>>> fetchAllStations() async {
    if (await networkInfo.isConnected) {
      try {
        final stationDetails = await remoteDataSource.fetchAllStations();
        return Right(stationDetails);
      } on ServerFailure catch (e) {
        return Left(e);
      }
    } else {
      return Left(CacheFailure(properties: []));
    }
  }
}
