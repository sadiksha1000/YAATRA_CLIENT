part of 'fetch_trip_cubit.dart';

class FetchTripState extends Equatable {
  final StationModel selectedFromStation;
  final StationModel selectedToStation;
  final String errorMessage;
  final String successMessage;
  final List<TripModel> trip;
  // final Status status;

  FetchTripState({
    required this.selectedFromStation,
    required this.selectedToStation,
    required this.errorMessage,
    required this.successMessage,
    required this.trip,
    // required this.status,
  });

  @override
  List<Object?> get props => [
        selectedFromStation,
        selectedToStation,
        errorMessage,
        successMessage,
        trip,
        // status
      ];

  factory FetchTripState.initial() {
    return FetchTripState(
      selectedFromStation: StationModel.empty,
      selectedToStation: StationModel.empty,
      errorMessage: '',
      successMessage: '',
      trip: [],
      // status: Status.initial,
    );
  }

  FetchTripState copyWith({
    StationModel? selectedFromStation,
    StationModel? selectedToStation,
    String? errorMessage,
    String? successMessage,
    List<TripModel>? trip,
    // Status? status,
  }) {
    return FetchTripState(
      selectedFromStation: selectedFromStation ?? this.selectedFromStation,
      selectedToStation: selectedToStation ?? this.selectedToStation,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
      trip: trip ?? this.trip,
      // status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'selectedFromStation': selectedFromStation.toMap(),
      'selectedToStation': selectedToStation.toMap(),
      'errorMessage': errorMessage,
      'successMessage': successMessage,
      'trip': trip,
      // 'status': status.index,
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
      trip: TripModel.fromMap(map['trip'], message: '') as List<TripModel>,
      // status: Status.values[map['status']],
    );
  }
}
