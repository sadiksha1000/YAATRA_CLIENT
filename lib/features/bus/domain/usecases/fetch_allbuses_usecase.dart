import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/bus.dart';
import '../repositories/bus_repository.dart';

class FetchAllBusesUseCase {
  final BusRepository busRepository;

  FetchAllBusesUseCase(this.busRepository);

  Future<Either<Failure, List<Bus>>> call({
    required String sourceParams,
    required String destinationParams,
  }) async {
    return busRepository.fetchAllBuses(
      sourceParams: sourceParams,
      destinationParams: destinationParams,
    );
  }
}
