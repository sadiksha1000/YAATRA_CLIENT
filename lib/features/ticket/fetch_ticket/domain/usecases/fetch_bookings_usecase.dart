import 'package:dartz/dartz.dart';
import '../repositories/fetch_ticket_repository.dart';

import '../../../../../core/errors/failure.dart';
import '../entities/booking.dart';

class FetchBookingsUseCase {
  final FetchTicketRepository bookingRepository;

  FetchBookingsUseCase(this.bookingRepository);

  Future<Either<Failure, List<Booking>>> call({required String userId}) async {
    return bookingRepository.fetchAllBookings(userId: userId);
  }
}
