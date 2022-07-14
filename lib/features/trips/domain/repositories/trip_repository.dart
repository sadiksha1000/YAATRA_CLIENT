import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/station.dart';
import '../entities/trip.dart';

class TripRepository {
  var currentTrip = Trip.empty;
  var currentStation = Station.empty;

  Future<Either<Failure, List<dynamic>>> fetchAllTrips({
    required String selectedFromStation,
    required String selectedtoStation,
    required DateTime selectedDate,
    required int seats,
  }) async {
    return Right([Trip.empty]);
  }

  Future<Either<Failure, Trip>> fetchTripById({
    required String id,
  }) async {
    return Right(Trip.empty);
  }

  Future<Either<Failure, List<Station>>> fetchAllStations() async {
    return const Right([]);
  }
}
