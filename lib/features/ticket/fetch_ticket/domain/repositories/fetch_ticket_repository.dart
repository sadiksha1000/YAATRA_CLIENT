import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../entities/booking.dart';


class FetchTicketRepository{
  var currentBooking=Booking.empty;

  Future<Either<Failure,List<Booking>>> fetchAllBookings({required String userId})async{
      return Right([Booking.empty]);
  }
}