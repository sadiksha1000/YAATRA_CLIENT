import 'package:dartz/dartz.dart';
import 'package:yaatra_client/core/errors/failure.dart';
import 'package:yaatra_client/core/config/response_model.dart';
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

  @override
  Future<Either<Failure, ResponseModel>> createBooking({
    required List<Map<String, String>> passengersDetails,
    required Map<String, String> contactDetails,
    required String tripId,
    required String userId,
    required String bookingSessionId,
    required int totalAmount,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final sessionDetails = await remoteDataSource.createBooking(
          passengersDetails: passengersDetails,
          contactDetails: contactDetails,
          bookingSessionId: bookingSessionId,
          tripId: tripId,
          userId: userId,
          totalAmount: totalAmount,
        );

        return Right(sessionDetails);
      } on ServerFailure catch (e) {
        return Left(e);
      }
    } else {
      return Left(
          ServerFailure(properties: [], message: 'No internet connection'));
    }
  }
}
