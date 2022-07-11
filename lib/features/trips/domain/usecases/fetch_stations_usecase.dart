import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../trips/domain/entities/station.dart';
import '../repositories/trip_repository.dart';

class FetchAllStationsUseCase {
  final TripRepository tripRepository;

  FetchAllStationsUseCase(this.tripRepository);

  Future<Either<Failure, List<Station>>> call() async {
    return tripRepository.fetchAllStations();
  }
}
