part of 'fetch_trip_cubit.dart';

class FetchTripState extends Equatable {
  final StationModel selectedFromStation;
  final StationModel selectedToStation;
  final String errorMessage;
  final String successMessage;
  final List<dynamic> trip;
  final Status searchBusStatus;

  FetchTripState({
    required this.selectedFromStation,
    required this.selectedToStation,
    required this.errorMessage,
    required this.successMessage,
    required this.trip,
    required this.searchBusStatus,
  });

  @override
  List<Object?> get props => [
        selectedFromStation,
        selectedToStation,
        errorMessage,
        successMessage,
        trip,
        searchBusStatus,
      ];

  factory FetchTripState.initial() {
    return FetchTripState(
      selectedFromStation: StationModel.empty,
      selectedToStation: StationModel.empty,
      errorMessage: '',
      successMessage: '',
      trip: [],
      searchBusStatus: Status.initial,
    );
  }

  FetchTripState copyWith({
    StationModel? selectedFromStation,
    StationModel? selectedToStation,
    String? errorMessage,
    String? successMessage,
    List<dynamic>? trip,
    Status? searchBusStatus,
  }) {
    return FetchTripState(
      selectedFromStation: selectedFromStation ?? this.selectedFromStation,
      selectedToStation: selectedToStation ?? this.selectedToStation,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
      trip: trip ?? this.trip,
      searchBusStatus: searchBusStatus ?? this.searchBusStatus,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'selectedFromStation': selectedFromStation.toMap(),
      'selectedToStation': selectedToStation.toMap(),
      'errorMessage': errorMessage,
      'successMessage': successMessage,
      'trip': trip,
      'searchBusStatus': searchBusStatus.index,
    };
  }

  factory FetchTripState.fromMap(Map<String, dynamic> map) {
    return FetchTripState(
      selectedFromStation:
          StationModel.fromMap(map['selectedFromStation'], message: ''),
      selectedToStation:
          StationModel.fromMap(map['selectedToStation'], message: ''),
      errorMessage: map['errorMessage'],
      successMessage: map['successMessage'],
      trip: TripModel.fromMap(map['trip'], message: '') as List<dynamic>,
      searchBusStatus: Status.values[map['searchBusStatus']],
    );
  }
}
