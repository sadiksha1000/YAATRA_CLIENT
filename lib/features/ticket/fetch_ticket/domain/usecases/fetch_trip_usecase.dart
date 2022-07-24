import 'package:dartz/dartz.dart';
import 'package:yaatra_client/features/ticket/fetch_ticket/domain/repositories/fetch_ticket_repository.dart';
import 'package:yaatra_client/features/trips/data/models/trip_model.dart';

import '../../../../../core/errors/failure.dart';
import '../entities/booking.dart';

class FetchCurrentTripUseCase {
  final FetchTicketRepository ticketRepository;

  FetchCurrentTripUseCase(this.ticketRepository);

  Future<Either<Failure, TripModel>> call({required String tripId}) async {
    return ticketRepository.fetchTrip(tripId: tripId);
  }
}
