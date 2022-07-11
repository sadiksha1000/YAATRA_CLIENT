import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../core/network/network_info.dart';
import '../../../../../core/utils/input_validator.dart';
import '../../../../trips/data/models/station_model.dart';
import '../../../../trips/domain/entities/station.dart';
import '../../../domain/usecases/fetch_allbuses_usecase.dart';
import '../fetch_bus_cubit/fetch_buses_cubit.dart';

import '../../../../trips/data/models/bus_model.dart';

part 'search_bus_state.dart';

class SearchBusCubit extends Cubit<SearchBusState> with InputValidatorMixin {
  NetworkInfo networkInfo;
  FetchAllBusesUseCase fetchAllBusesUseCase;
  SearchBusCubit(
      {required NetworkInfo network,
      required FetchAllBusesUseCase fetchBusesCase})
      : networkInfo = network,
        fetchAllBusesUseCase = fetchBusesCase,
        super(SearchBusState.initial());

  // behavior string
  // Streams
  final _selectedFromStation = BehaviorSubject<Station>();
  final _selectedToStation = BehaviorSubject<Station>();
  final _selectedDate = BehaviorSubject<DateTime>();
  final _selectedNumberOfSeats = BehaviorSubject<String>();

  // Sinks
  Function(Station) get selectedFromStationChanged =>
      _selectedFromStation.sink.add;
  Function(Station) get selectedToStationChanged => _selectedToStation.sink.add;
  Function(DateTime) get selectedDateChanged => _selectedDate.sink.add;
  Function(String) get selectedNumberOfSeatsChanged =>
      _selectedNumberOfSeats.sink.add;

  // Getters
  Stream<Station> get selectedFromStation => _selectedFromStation.stream;
  Stream<Station> get selectedToStation => _selectedToStation.stream;
  Stream<DateTime> get selectedDate => _selectedDate.stream;
  Stream<String> get selectedNumberOfSeats => _selectedNumberOfSeats.stream;

  // dispose
  void dispose() {
    _selectedFromStation.close();
    _selectedToStation.close();
    _selectedDate.close();
    _selectedNumberOfSeats.close();
  }

  // validators
  Stream<bool> get submiValid =>
      Rx.combineLatest2(selectedFromStation, selectedToStation, (f, t) => true);

  Stream<bool> get isFromStationValid => Rx.combineLatest2(
      selectedFromStation, selectedFromStation, (a, b) => true);
  Stream<bool> get isToStationValid =>
      Rx.combineLatest2(selectedToStation, selectedToStation, (a, b) => true);

  Future<void> searchBuses() async {
    final fromStation = _selectedFromStation.value;
    final toStation = _selectedToStation.value;
    print("Source : $fromStation");
    print("Destination : $toStation");
    var fetchBusesEither = await fetchAllBusesUseCase(
      sourceParams: fromStation.stationName,
      destinationParams: toStation.stationName,
    );
    print("Fetch buses either: $fetchBusesEither");
    fetchBusesEither.fold(
      (failure) => {
        print("error"),
        emit(state.copyWith(
          errorMessage: failure.message,
        ))
      },
      (busModel) => {
        print("success"),
        emit(state.copyWith(
          // bus: busModel as BusModel,
          successMessage: "Buses fetched successfully",
        ))
      },
    );
  }
}
