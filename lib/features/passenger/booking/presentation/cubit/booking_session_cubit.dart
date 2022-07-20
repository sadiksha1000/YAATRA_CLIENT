import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yaatra_client/core/utils/status.dart';
import 'package:yaatra_client/features/passenger/booking/data/models/booking_session_failure_model.dart';
import 'package:yaatra_client/features/passenger/booking/data/models/booking_session_success_model.dart';
import 'package:yaatra_client/features/passenger/booking/domain/usecases/check_seat_availability_usecase.dart';

import '../../../../trips/domain/entities/trip_seat.dart';

part 'booking_session_state.dart';

class BookingSessionCubit extends Cubit<BookingSessionState> {
  CheckSeatAvailabilityUseCase checkSeatAvailabilityUseCase;
  BookingSessionCubit({
    required CheckSeatAvailabilityUseCase checkSeatAvailability,
  })  : checkSeatAvailabilityUseCase = checkSeatAvailability,
        super(BookingSessionState.initial());

  void cancelSessionLoading() {
    emit(state.copyWith(sessionStatus: Status.initial));
  }

  Future<void> checkSeatsAvailability(
      {required List<TripSeat> selectedSeats,
      required String tripId,
      required String userId}) async {
    emit(state.copyWith(sessionStatus: Status.loading));
    List<String> selectedSeatsIds =
        selectedSeats.map((seat) => seat.id).toList();
    var bookingSessionEither = await checkSeatAvailabilityUseCase(
      selectedSeats: selectedSeatsIds,
      tripId: tripId,
      userId: userId,
    );

    bookingSessionEither.fold((failure) {
      emit(state.copyWith(
          sessionStatus: Status.error, bookingFailureSession: failure));
    }, (success) {
      emit(state.copyWith(
          sessionStatus: Status.success, bookingSuccessSession: success));
    });
  }
}
