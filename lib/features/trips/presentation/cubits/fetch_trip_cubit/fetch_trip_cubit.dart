import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../core/network/network_info.dart';
import '../../../../../core/utils/input_validator.dart';

import '../../../../../core/utils/status.dart';
import '../../../data/models/station_model.dart';
import '../../../data/models/trip_model.dart';
import '../../../domain/entities/station.dart';
import '../../../domain/usecases/fetch_trips_usecase.dart';

part 'fetch_trip_state.dart';

class FetchTripCubit extends Cubit<FetchTripState> with InputValidatorMixin {
  NetworkInfo networkInfo;
  FetchTripsUseCase fetchTripsUseCase;

  FetchTripCubit(
      {required NetworkInfo network, required FetchTripsUseCase fetchTripsCase})
      : networkInfo = network,
        fetchTripsUseCase = fetchTripsCase,
        super(FetchTripState.initial());

  // behavior string
  // Streams
  final _selectedFromStation = BehaviorSubject<Station>();
  final _selectedToStation = BehaviorSubject<Station>();
  final _selectedDate = BehaviorSubject<DateTime>();
  final _seats = BehaviorSubject<String>();

  // Sinks
  Function(Station) get selectedFromStationChanged =>
      _selectedFromStation.sink.add;
  Function(Station) get selectedToStationChanged => _selectedToStation.sink.add;
  Function(DateTime) get selectedDateChanged => _selectedDate.sink.add;
  Function(String) get selectedNumberOfSeatsChanged => _seats.sink.add;

  // Getters
  Stream<Station> get selectedFromStation => _selectedFromStation.stream;
  Stream<Station> get selectedToStation => _selectedToStation.stream;
  Stream<DateTime> get selectedDate => _selectedDate.stream;
  Stream<String> get selectedNumberOfSeats => _seats.stream;

  // dispose
  void dispose() {
    _selectedFromStation.close();
    _selectedToStation.close();
    _selectedDate.close();
    _seats.close();
  }

  // validators
  Stream<bool> get submitValid =>
      Rx.combineLatest2(selectedFromStation, selectedToStation, (f, t) => true);

  Stream<bool> get isFromStationValid => Rx.combineLatest2(
      selectedFromStation, selectedFromStation, (a, b) => true);
  Stream<bool> get isToStationValid =>
      Rx.combineLatest2(selectedToStation, selectedToStation, (a, b) => true);

  Future<void> searchBuses() async {
    final selectedfromStation = _selectedFromStation.value;
    final selectedtoStation = _selectedToStation.value;
    final selectedDate = _selectedDate.value;
    final seats = _seats.value;
    print("Source : ${selectedfromStation.stationName}");
    print("Destination : ${selectedtoStation.stationName}");
    print("SelectedDate : $selectedDate");
    print("Seats : $seats");
    var fetchTripsEither = await fetchTripsUseCase(
      selectedFromStation: selectedfromStation.stationName,
      selectedtoStation: selectedtoStation.stationName,
      selectedDate: selectedDate,
      seats: int.parse(seats),
    );
    fetchTripsEither.fold(
      (failure) => {
        emit(state.copyWith(
          errorMessage: failure.message,
        ))
      },
      (tripModel) => {
        emit(state.copyWith(
          successMessage: "Trips fetched successfully",
          trip: tripModel as List<TripModel>,
        ))
      },
    );
  }
}
