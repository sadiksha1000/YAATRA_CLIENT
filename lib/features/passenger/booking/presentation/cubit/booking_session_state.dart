part of 'booking_session_cubit.dart';

class BookingSessionState extends Equatable {
  final BookingSessionSuccessModel bookingSuccessSession;
  final BookingSessionFailureModel bookingFailureSession;

  final Status sessionStatus;
  const BookingSessionState({
    required this.sessionStatus,
    required this.bookingFailureSession,
    required this.bookingSuccessSession,
  });

  factory BookingSessionState.initial() => BookingSessionState(
        sessionStatus: Status.initial,
        bookingFailureSession: BookingSessionFailureModel.empty,
        bookingSuccessSession: BookingSessionSuccessModel.empty,
      );

  @override
  List<Object> get props => [
        bookingFailureSession,
        bookingSuccessSession,
        sessionStatus,
      ];

  // copy with
  BookingSessionState copyWith({
    BookingSessionSuccessModel? bookingSuccessSession,
    BookingSessionFailureModel? bookingFailureSession,
    Status? sessionStatus,
  }) {
    return BookingSessionState(
      sessionStatus: sessionStatus ?? this.sessionStatus,
      bookingFailureSession:
          bookingFailureSession ?? this.bookingFailureSession,
      bookingSuccessSession:
          bookingSuccessSession ?? this.bookingSuccessSession,
    );
  }
}
