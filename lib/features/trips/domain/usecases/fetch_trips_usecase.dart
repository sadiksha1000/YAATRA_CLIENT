import 'package:dartz/dartz.dart';
import '../repositories/trip_repository.dart';

import '../../../../core/errors/failure.dart';
import '../entities/trip.dart';

class FetchTripsUseCase {
  final TripRepository tripRepository;

  FetchTripsUseCase(this.tripRepository);

  Future<Either<Failure, List<dynamic>>> call({
    required String selectedFromStation,
    required String selectedtoStation,
    required DateTime selectedDate,
    required int seats,
  }) async {
    return tripRepository.fetchAllTrips(
      selectedFromStation: selectedFromStation,
      selectedtoStation: selectedtoStation,
      selectedDate: selectedDate,
      seats: seats,
    );
  }
}
