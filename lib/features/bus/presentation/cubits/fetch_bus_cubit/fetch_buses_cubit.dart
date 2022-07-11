import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../core/network/network_info.dart';
import '../../../../../core/utils/input_validator.dart';
import '../../../../trips/data/models/bus_model.dart';
import '../../../domain/usecases/fetch_allbuses_usecase.dart';

part 'fetch_buses_state.dart';

class FetchAllBusesCubit extends Cubit<FetchAllBusesState>
    with InputValidatorMixin {
  NetworkInfo networkInfo;
  FetchAllBusesUseCase fetchAllBusesUseCase;

  FetchAllBusesCubit({
    required NetworkInfo network,
    required FetchAllBusesUseCase fetchBusesCase,
  })  : fetchAllBusesUseCase = fetchBusesCase,
        networkInfo = network,
        super(FetchAllBusesState.initial());

  // streams
  final _sourceController = BehaviorSubject<String>();
  final _destinationController = BehaviorSubject<String>();

  // sinks
  Function(String) get sourceChanged => _sourceController.sink.add;
  Function(String) get destinationChanged => _destinationController.sink.add;

  // getters
  Stream<String> get source =>
      _sourceController.stream.transform(emptyValidator);
  Stream<String> get destination =>
      _destinationController.stream.transform(emptyValidator);

  // validators
  Stream<bool> get submitValid =>
      Rx.combineLatest2(source, destination, (s, d) => true);

  Stream<bool> get isSourceValid =>
      Rx.combineLatest2(source, source, (a, b) => true);
  Stream<bool> get isDestinationValid =>
      Rx.combineLatest2(destination, destination, (a, b) => true);

  Future<void> fetchAllBuses() async {
    print("Reached at fetch bus fucntion");
    final source = _sourceController.value;
    final destination = _destinationController.value;
    print("Source Controller: $source");
    print("Destination Controller: $destination");
    var fetchBusesEither = await fetchAllBusesUseCase(
      sourceParams: source,
      destinationParams: destination,
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
          bus: busModel as BusModel,
          successMessage: "Buses fetched successfully",
        ))
      },
    );
  }
}
