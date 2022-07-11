import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../entities/bus.dart';
import '../../../trips/domain/entities/station.dart';

class BusRepository {
  var currentBus = Bus.empty;
  var currentStation = Station.empty;

  Future<Either<Failure, List<Bus>>> fetchAllBuses({
    required String sourceParams,
    required String destinationParams,
  }) async {
    return const Right([Bus.empty]);
  }

  Future<Either<Failure,List<Station>>> fetchAllStations() async {
    return const Right([Station.empty]);
  }
}
