import 'package:dartz/dartz.dart';
import 'package:yaatra_client/features/passenger/booking/data/models/booking_session_failure_model.dart';
import 'package:yaatra_client/features/passenger/booking/data/models/booking_session_success_model.dart';
import 'package:yaatra_client/features/passenger/booking/domain/repositories/booking_repository.dart';

class CheckSeatAvailabilityUseCase {
  final BookingRepository bookingRepository;

  CheckSeatAvailabilityUseCase(this.bookingRepository);

  Future<Either<BookingSessionFailureModel, BookingSessionSuccessModel>> call({
    required List<String> selectedSeats,
    required String tripId,
    required String userId,
  }) async {
    return bookingRepository.checkSeatAvailability(
      selectedSeats: selectedSeats,
      tripId: tripId,
      userId: userId,
    );
  }
}
