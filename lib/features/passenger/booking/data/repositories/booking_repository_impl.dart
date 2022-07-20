import 'package:dartz/dartz.dart';
import 'package:yaatra_client/core/network/network_info.dart';
import 'package:yaatra_client/features/passenger/booking/data/datasources/booking_remote_datasource.dart';
import 'package:yaatra_client/features/passenger/booking/data/models/booking_session_success_model.dart';
import 'package:yaatra_client/features/passenger/booking/data/models/booking_session_failure_model.dart';

import '../../domain/repositories/booking_repository.dart';

class BookingRepositoryImpl implements BookingRepository {
  final BookingRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  BookingRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<BookingSessionFailureModel, BookingSessionSuccessModel>>
      checkSeatAvailability(
          {required List<String> selectedSeats,
          required String tripId,
          required String userId}) async {
    if (await networkInfo.isConnected) {
      try {
        final sessionDetails = await remoteDataSource.checkSeatAvailability(
          selectedSeats: selectedSeats,
          tripId: tripId,
          userId: userId,
        );
        return Right(sessionDetails);
      } on BookingSessionFailureModel catch (e) {
        return Left(e);
      }
    } else {
      return const Left(BookingSessionFailureModel(
          unAvailableSeats: [], message: 'No internet connection'));
    }
  }
}
