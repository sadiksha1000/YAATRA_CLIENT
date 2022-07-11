import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../../core/network/network_info.dart';
import '../../../data/models/booking_model.dart';

import '../../../../../trips/data/models/user_model.dart';
import '../../../domain/usecases/fetch_bookings_usecase.dart';

part 'fetch_tickets_state.dart';

class FetchTicketsCubit extends Cubit<FetchTicketsState> {
  NetworkInfo networkInfo;
  FetchBookingsUseCase fetchTicketsUseCase;

  FetchTicketsCubit(
      {required NetworkInfo network,
      required FetchBookingsUseCase fetchBookingCase})
      : networkInfo = network,
        fetchTicketsUseCase = fetchBookingCase,
        super(FetchTicketsState.initial());

  Future<void> fetchAllBookings(String userId) async {
    var fetchTicketsEither = await fetchTicketsUseCase(userId: userId);
    fetchTicketsEither.fold(
        (failure) => {emit(state.copyWith(errorMessage: failure.message))},
        (bookingModel) => emit(state.copyWith(
            successMessage: 'Bookings fetched successfully',
            tickets: bookingModel as List<BookingModel>)));
  }
}
