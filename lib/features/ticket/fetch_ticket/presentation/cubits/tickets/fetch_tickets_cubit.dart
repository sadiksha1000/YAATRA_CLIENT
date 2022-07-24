import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yaatra_client/features/ticket/fetch_ticket/domain/usecases/fetch_trip_usecase.dart';
import 'package:yaatra_client/features/trips/data/models/trip_model.dart';
import '../../../../../../core/network/network_info.dart';
import '../../../data/models/booking_model.dart';

import '../../../../../trips/data/models/user_model.dart';
import '../../../domain/usecases/fetch_bookings_usecase.dart';

part 'fetch_tickets_state.dart';

class FetchTicketsCubit extends Cubit<FetchTicketsState> {
  NetworkInfo networkInfo;
  FetchBookingsUseCase fetchTicketsUseCase;
  FetchCurrentTripUseCase fetchCurrentTripUseCase;

  FetchTicketsCubit({
    required NetworkInfo network,
    required FetchBookingsUseCase fetchBookingCase,
    required FetchCurrentTripUseCase fetchCurrentTripCase,
  })  : networkInfo = network,
        fetchTicketsUseCase = fetchBookingCase,
        fetchCurrentTripUseCase = fetchCurrentTripCase,
        super(FetchTicketsState.initial());

  Future<void> fetchAllBookings(String userId) async {
    var fetchTicketsEither = await fetchTicketsUseCase(userId: userId);
    fetchTicketsEither.fold(
        (failure) => {emit(state.copyWith(errorMessage: failure.message))},
        (bookingModel) => emit(state.copyWith(
            successMessage: 'Bookings fetched successfully',
            tickets: bookingModel as List<BookingModel>)));
  }

  Future<void> fetchTrip(String tripId) async {
    print("Trip id in cubit: $tripId");
    var fetchTripEither = await fetchCurrentTripUseCase(tripId: tripId);
    fetchTripEither.fold(
        (failure) => {emit(state.copyWith(errorMessage: failure.message))},
        (tripModel) => {
              emit(state.copyWith(
                successMessage: 'Trip fetched successfully',
                currentTrip: tripModel as TripModel,
              ))
            });
  }
}
