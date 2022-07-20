import 'package:dartz/dartz.dart';
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
}
