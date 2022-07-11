import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../trips/domain/entities/station.dart';
import '../repositories/bus_repository.dart';

class FetchAllStationsUseCase {
  final BusRepository busRepository;

  FetchAllStationsUseCase(this.busRepository);

  Future<Either<Failure, List<Station>>> call() async {
    return busRepository.fetchAllStations();
  }
}
