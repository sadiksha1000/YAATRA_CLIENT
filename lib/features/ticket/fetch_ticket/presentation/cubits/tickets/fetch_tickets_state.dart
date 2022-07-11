part of 'fetch_tickets_cubit.dart';

class FetchTicketsState extends Equatable {
  final UserModel userId;
  final String errorMessage;
  final String successMessage;
  final List<BookingModel> tickets;

  FetchTicketsState({
    required this.userId,
    required this.errorMessage,
    required this.successMessage,
    required this.tickets,
  });

  @override
  List<Object?> get props => [
        userId,
        errorMessage,
        successMessage,
        tickets,
      ];

  factory FetchTicketsState.initial() {
    return FetchTicketsState(
      userId: UserModel.empty,
      errorMessage: '',
      successMessage: '',
      tickets: [],
    );
  }

  FetchTicketsState copyWith({
    UserModel? userId,
    String? errorMessage,
    String? successMessage,
    List<BookingModel>? tickets,
  }) {
    return FetchTicketsState(
      userId: userId ?? this.userId,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
      tickets: tickets ?? this.tickets,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId.toMap(),
      'errorMessage': errorMessage,
      'successMessage': successMessage,
      'tickets': tickets.map((e) => e.toMap()).toList(),
    };
  }

  static FetchTicketsState fromMap(Map<String, dynamic> map) {
    return FetchTicketsState(
      userId: UserModel.fromMap(map['userId'] as Map<String, dynamic>),
      errorMessage: map['errorMessage'] as String,
      successMessage: map['successMessage'] as String,
      tickets: BookingModel.fromMap(map['tickets'], message: '') as List<BookingModel>,
    );
  }

}

