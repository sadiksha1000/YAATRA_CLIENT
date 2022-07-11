import 'package:dartz/dartz.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/bus_remote_datasource.dart';
import '../../../../../core/errors/failure.dart';
import '../../domain/entities/bus.dart';
import '../../../trips/domain/entities/station.dart';
import '../../domain/repositories/bus_repository.dart';
import '../../../trips/data/models/bus_model.dart';
import '../../../trips/data/models/station_model.dart';

class BusRepositoryImpl implements BusRepository {
  final BusRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  BusRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  var currentBus = Bus.empty;
  var currentStation = Station.empty;

  @override
  Future<Either<Failure, List<BusModel>>> fetchAllBuses(
      {required String sourceParams, required String destinationParams}) async {
    if (await networkInfo.isConnected) {
      try {
        final busDetails = await remoteDataSource.fetchAllBuses(
          sourceParams: sourceParams,
          destinationParams: destinationParams,
        );
        return Right(busDetails);
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
