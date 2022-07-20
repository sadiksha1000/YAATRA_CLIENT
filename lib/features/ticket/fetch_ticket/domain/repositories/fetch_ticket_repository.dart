import 'package:dartz/dartz.dart';
import 'package:yaatra_client/features/trips/data/models/trip_model.dart';

import '../../../../../core/errors/failure.dart';
import '../entities/booking.dart';

class FetchTicketRepository {
  var currentBooking = Booking.empty;

  Future<Either<Failure, List<Booking>>> fetchAllBookings(
      {required String userId}) async {
    return Right([Booking.empty]);
  }

  Future<Either<Failure, TripModel>> fetchTrip({required String tripId}) async {
    return Right(TripModel.empty);
  }
}
