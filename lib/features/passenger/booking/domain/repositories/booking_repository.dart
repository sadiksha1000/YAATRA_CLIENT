import 'package:dartz/dartz.dart';
import 'package:yaatra_client/core/config/response_model.dart';
import 'package:yaatra_client/core/errors/failure.dart';
import 'package:yaatra_client/features/passenger/booking/data/models/booking_session_failure_model.dart';
import 'package:yaatra_client/features/passenger/booking/data/models/booking_session_success_model.dart';

class BookingRepository {
  Future<Either<BookingSessionFailureModel, BookingSessionSuccessModel>>
      checkSeatAvailability(
          {required List<String> selectedSeats,
          required String tripId,
          required String userId}) async {
    return Right(BookingSessionSuccessModel.empty);
  }

  Future<Either<Failure, ResponseModel>> createBooking({
    required List<Map<String, String>> passengersDetails,
    required Map<String, String> contactDetails,
    required String tripId,
    required String userId,
    required String bookingSessionId,
    required int totalAmount,
  }) async {
    return Right(ResponseModel.empty);
  }
}
