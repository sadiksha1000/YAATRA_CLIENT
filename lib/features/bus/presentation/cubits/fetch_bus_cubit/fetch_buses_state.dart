part of 'fetch_buses_cubit.dart';

class FetchAllBusesState extends Equatable {
  final BusModel bus;
  final String errorMessage;
  final String successMessage;

  FetchAllBusesState({
    required this.bus,
    required this.errorMessage,
    required this.successMessage,
  });

  @override
  List<Object?> get props => [bus, errorMessage, successMessage];

  factory FetchAllBusesState.initial() {
    return FetchAllBusesState(
      bus: BusModel.empty,
      errorMessage: '',
      successMessage: '',
    );
  }

  FetchAllBusesState copyWith({
    BusModel? bus,
    String? errorMessage,
    String? successMessage,
  }) {
    return FetchAllBusesState(
      bus: bus ?? this.bus,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'bus': bus.toMap(),
      'errorMessage': errorMessage,
      'successMessage': successMessage,
    };
  }

  factory FetchAllBusesState.fromMap(Map<String, dynamic> map) {
    return FetchAllBusesState(
      bus: BusModel.fromMap(map['data']),
      errorMessage: map['errorMessage'],
      successMessage: map['successMessage'],
    );
  }

  String toJson() => json.encode(toMap());

  factory FetchAllBusesState.fromJson(String source) =>
      FetchAllBusesState.fromMap(json.decode(source));
}
