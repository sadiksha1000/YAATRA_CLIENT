import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/models/station_model.dart';

import '../../../../bus/domain/usecases/fetch_stations_usecase.dart';

import '../../../../../core/network/network_info.dart';
import '../../../../../core/utils/input_validator.dart';

part 'fetch_station_state.dart';

class FetchStationCubit extends Cubit<FetchStationState>
    with InputValidatorMixin {
  NetworkInfo networkInfo;
  FetchAllStationsUseCase fetchAllStationsUseCase;

  FetchStationCubit({
    required NetworkInfo network,
    required FetchAllStationsUseCase fetchStationsCase,
  })  : networkInfo = network,
        fetchAllStationsUseCase = fetchStationsCase,
        super(FetchStationState.initial());

  Future<void> fetchAllStations() async {
    print("Reachged at station cubit");
    final stationsEither = await fetchAllStationsUseCase();
    stationsEither.fold(
      (failure) => {
        print("Failed to fetch stations"),
        emit(state.copyWith(errorMessage: failure.message)),
      },
      (stations) => {
        print("Successfully fetched stations$stations"),
        emit(state.copyWith(station: stations as List<StationModel>)),
      },
    );
  }
}
