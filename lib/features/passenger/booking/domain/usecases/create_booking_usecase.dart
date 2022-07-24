import 'package:dartz/dartz.dart';
import 'package:yaatra_client/core/config/response_model.dart';
import 'package:yaatra_client/core/errors/failure.dart';
import 'package:yaatra_client/features/passenger/booking/domain/repositories/booking_repository.dart';

class CreateBookingUseCase {
  final BookingRepository bookingRepository;

  CreateBookingUseCase(this.bookingRepository);

  Future<Either<Failure, ResponseModel>> call({
    required List<Map<String, String>> passengersDetails,
    required Map<String, String> contactDetails,
    required String tripId,
    required String userId,
    required String bookingSessionId,
    required int totalAmount,
  }) async {
    return bookingRepository.createBooking(
      passengersDetails: passengersDetails,
      contactDetails: contactDetails,
      bookingSessionId: bookingSessionId,
      tripId: tripId,
      userId: userId,
      totalAmount: totalAmount,
    );
  }
}
