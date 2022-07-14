import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yaatra_client/features/trips/domain/entities/trip_seat.dart';

import '../../../../../core/utils/status.dart';
import '../../../../trips/domain/entities/seat.dart';
import '../../../../trips/domain/entities/trip.dart';
import '../../../../trips/domain/usecases/fetch_trip_byid_usecase.dart';

part 'booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  FetchTripByIdUseCase fetchTripByIdUseCase;
  BookingCubit({required FetchTripByIdUseCase fetchTripById})
      : fetchTripByIdUseCase = fetchTripById,
        super(BookingState.initial());

  List<TripSeat> allTripSeats = const [
    TripSeat(
      id: '',
      seat: Seat.empty,
      isAvailable: true,
      isBooked: false,
      isHolded: false,
    ),
    TripSeat(
      id: '',
      seat: Seat.empty,
      isAvailable: false,
      isBooked: true,
      isHolded: false,
    ),
    TripSeat(
      id: '',
      seat: Seat.empty,
      isAvailable: false,
      isBooked: false,
      isHolded: true,
    ),
    TripSeat(
      id: '',
      seat: Seat.empty,
      isAvailable: true,
      isBooked: false,
      isHolded: false,
    ),
    TripSeat(
      id: '',
      seat: Seat.empty,
      isAvailable: true,
      isBooked: false,
      isHolded: false,
    ),
  ];

  void fetchAllTripSeats(List<dynamic> tripSeats) {
    emit(state.copyWith(allTripSeats: tripSeats));
  }

  Future<void> refreshSelectedTrip(String id) async {
    emit(state.copyWith(refreshSelectedTripStatus: Status.loading));
    final tripEither = await fetchTripByIdUseCase(id: id);
    tripEither.fold((failure) {
      emit(state.copyWith(refreshSelectedTripStatus: Status.error));
    }, (trip) {
      print(" i am trip in booking cubit ${trip.allTripSeats}");
      emit(state.copyWith(
        selectedTrip: trip,
        refreshSelectedTripStatus: Status.success,
      ));
    });
  }

  void updateSelectedSeats(index, isSelected) {
    emit(state.copyWith(allTripSeats: allTripSeats));
  }

  void changeSelectedTrip(Trip trip) {
    emit(state.copyWith(selectedTrip: trip));
  }

  void addSelectedSeatByUser(TripSeat seat) {
    emit(state.copyWith(
        selectedSeatsByUser: [...state.selectedSeatsByUser, seat],
        totalPrice: state.totalPrice + seat.seat.ticketPrice));
  }

  void removeSelectedSeatByUser(TripSeat seat) {
    emit(
      state.copyWith(
          selectedSeatsByUser: state.selectedSeatsByUser
              .where((element) => element.id != seat.id)
              .toList(),
          totalPrice: state.totalPrice - seat.seat.ticketPrice),
    );
  }
}
