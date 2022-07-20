import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:yaatra_client/core/widgets/custom_snackbar.dart';
import 'package:yaatra_client/features/passenger/booking/data/models/passenger_details.dart';
import 'package:yaatra_client/features/passenger/booking/domain/usecases/create_booking_usecase.dart';
import 'package:yaatra_client/features/trips/domain/entities/trip_seat.dart';

import '../../../../../core/utils/status.dart';
import '../../../../trips/domain/entities/seat.dart';
import '../../../../trips/domain/entities/trip.dart';
import '../../../../trips/domain/usecases/fetch_trip_byid_usecase.dart';

part 'booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  FetchTripByIdUseCase fetchTripByIdUseCase;
  CreateBookingUseCase createBookingUseCase;
  BookingCubit(
      {required FetchTripByIdUseCase fetchTripById,
      required CreateBookingUseCase createBooking})
      : fetchTripByIdUseCase = fetchTripById,
        createBookingUseCase = createBooking,
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
        selectedSeatsByUser: [],
        totalPrice: 0,
      ));
    });
  }

  void updateSelectedSeats(index, isSelected) {
    emit(state.copyWith(allTripSeats: allTripSeats));
  }

  void changeSelectedTrip(Trip trip) {
    emit(state.copyWith(selectedTrip: trip));
  }

  void changePassengerAndContactDetails(
      {required List<PassengerDetailsModel> passengerDetails,
      required PassengerDetailsModel contactPersonDetails}) {
    emit(state.copyWith(
      passengerDetails: passengerDetails,
      contactPersonDetails: contactPersonDetails,
    ));
  }

  void addSelectedSeatByUser(TripSeat seat) {
    emit(state.copyWith(
        selectedSeatsByUser: [...state.selectedSeatsByUser, seat],
        totalPrice: state.totalPrice + seat.seat.ticketPrice));
  }

  void emptySelectedSeatAndPriceByUser() {
    emit(state.copyWith(selectedSeatsByUser: [], totalPrice: 0));
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

  void payWithKhalti(
      {required BuildContext context,
      required String userId,
      required String bookingSessionId}) async {
    var passengersDetails = state.passengerDetails.map((element) {
      return {
        'name': element.name,
        'phone': element.contact,
        'seatId': element.seat.id,
      };
    }).toList();
    var contactDetails = {
      'name': state.contactPersonDetails.name,
      'email': state.contactPersonDetails.email,
      'phone': state.contactPersonDetails.contact,
    };

    var tripId = state.selectedTrip.id;

    final config = PaymentConfig(
      amount: state.totalPrice * 100, // Amount should be in paisa
      productIdentity: 'ticket-booking', // will integrate session id here
      productName: 'Bus Tickets',
      productUrl: 'www.yaatra.com.np',
      additionalData: {
        // Not mandatory; can be used for reporting purpose
        'vendor': 'User ID', // will integrate user id here
      },
      mobile: state.contactPersonDetails
          .contact, // Not mandatory; can be used to fill mobile number field
      mobileReadOnly:
          false, // Not mandatory; makes the mobile field not editable
    );

    KhaltiScope.of(context).pay(
      config: config,
      preferences: [
        // PaymentPreference.connectIPS,
        // PaymentPreference.eBanking,
        // PaymentPreference.sct,
        PaymentPreference.khalti,
      ],
      onSuccess: (payment) {
        print("payment success ${payment.productName}");
        // create booked seats for all passenger
        // create booking for that event
        // update trip services

        customSnackbar(
            context: context, isError: false, message: 'Payment Successful');
      },
      onFailure: (failure) {
        print("payment success ${failure.message}");
        customSnackbar(
            context: context,
            isError: true,
            message: 'Your payment was failed');
      },
      onCancel: () async {
        ///
        /// nameOfPassenger
        /// phoneOfPassenger
        /// tripSeatIdOfPassenger
        /// create bookedSeats for all passengers
        /// totalAmountOfBooking
        /// contactPersonName
        /// contactPersonPhone
        /// contactPersonEmail
        /// userId
        /// tripId
        /// Create booking for that event
        /// push this booking to trip
        ///
        var bookingEither = await createBookingUseCase(
          bookingSessionId: bookingSessionId,
          userId: userId,
          tripId: tripId,
          contactDetails: contactDetails,
          passengersDetails: passengersDetails,
          totalAmount: state.totalPrice,
        );
        bookingEither.fold((failure) {
          customSnackbar(
              context: context,
              isError: true,
              message: 'Your payment was failed');
        }, (booking) {
          Navigator.of(context).popUntil((route) => route.isFirst);
          customSnackbar(
              context: context, isError: false, message: 'Payment Successful');
        });
        // customSnackbar(
        //     context: context,
        //     isError: true,
        //     message: 'Your payment was cancelled');
      },
    );
  }

  Future<void> clearSelectedUnavailableSeats(List<TripSeat> seats) async {
    var selectedSeats = state.selectedSeatsByUser;
    var totalPrice = state.totalPrice;

    seats.forEach((element) {
      var index =
          selectedSeats.indexWhere((element) => element.id == element.id);
      totalPrice -= element.seat.ticketPrice;
      if (index != -1) {
        selectedSeats.removeAt(index);
      }
    });
    emit(state.copyWith(
        selectedSeatsByUser: selectedSeats, totalPrice: totalPrice));
    refreshSelectedTrip(state.selectedTrip.id);
  }
}
