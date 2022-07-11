part of 'search_bus_cubit.dart';

class SearchBusState extends Equatable {
  final StationModel selectedFromStation;
  final StationModel selectedToStation;
  final String errorMessage;
  final String successMessage;

  SearchBusState({
    required this.selectedFromStation,
    required this.selectedToStation,
    required this.errorMessage,
    required this.successMessage,
  });

  @override
  List<Object?> get props =>
      [selectedFromStation, selectedToStation, errorMessage, successMessage];

  factory SearchBusState.initial() {
    return SearchBusState(
      selectedFromStation: StationModel.empty,
      selectedToStation: StationModel.empty,
      errorMessage: '',
      successMessage: '',
    );
  }

  SearchBusState copyWith({
    StationModel? selectedFromStation,
    StationModel? selectedToStation,
    String? errorMessage,
    String? successMessage,
  }) {
    return SearchBusState(
      selectedFromStation: selectedFromStation ?? this.selectedFromStation,
      selectedToStation: selectedToStation ?? this.selectedToStation,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'selectedFromStation': selectedFromStation.toMap(),
      'selectedToStation': selectedToStation.toMap(),
      'errorMessage': errorMessage,
      'successMessage': successMessage,
    };
  }

  factory SearchBusState.fromMap(Map<String, dynamic> map) {
    return SearchBusState(
      selectedFromStation:
          StationModel.fromMap(map['selectedFromStation'], message: ''),
      selectedToStation:
          StationModel.fromMap(map['selectedToStation'], message: ''),
      errorMessage: map['errorMessage'],
      successMessage: map['successMessage'],
    );
  }
}
