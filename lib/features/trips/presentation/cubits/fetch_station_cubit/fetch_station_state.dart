part of 'fetch_station_cubit.dart';

class FetchStationState extends Equatable {
  final List<StationModel> station;
  final String errorMessage;
  final String successMessage;

  FetchStationState({
    required this.station,
    required this.errorMessage,
    required this.successMessage,
  });

  @override
  List<Object?> get props => [station, errorMessage, successMessage];

  factory FetchStationState.initial() {
    return FetchStationState(
      station: [],
      errorMessage: '',
      successMessage: '',
    );
  }

  FetchStationState copyWith({
    List<StationModel>? station,
    String? errorMessage,
    String? successMessage,
  }) {
    return FetchStationState(
      station: station ?? this.station,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'station': station,
      'errorMessage': errorMessage,
      'successMessage': successMessage,
    };
  }

  factory FetchStationState.fromMap(Map<String, dynamic> map) {
    return FetchStationState(
      station: map['station'] as List<StationModel>,
      errorMessage: map['errorMessage'],
      successMessage: map['successMessage'],
    );
  }
}
