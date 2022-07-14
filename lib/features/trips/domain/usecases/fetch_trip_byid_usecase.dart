import 'package:dartz/dartz.dart';
import '../repositories/trip_repository.dart';

import '../../../../core/errors/failure.dart';
import '../entities/trip.dart';

class FetchTripByIdUseCase {
  final TripRepository tripRepository;

  FetchTripByIdUseCase(this.tripRepository);

  Future<Either<Failure, Trip>> call({
    required String id,
  }) async {
    return tripRepository.fetchTripById(
      id: id,
    );
  }
}
