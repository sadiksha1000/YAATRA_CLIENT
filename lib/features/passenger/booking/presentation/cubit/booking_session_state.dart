part of 'booking_session_cubit.dart';

class BookingSessionState extends Equatable {
  final BookingSessionSuccessModel bookingSuccessSession;
  final BookingSessionFailureModel bookingFailureSession;
  final int timeOutInSeconds;

  final Status sessionStatus;
  const BookingSessionState({
    required this.sessionStatus,
    required this.bookingFailureSession,
    required this.bookingSuccessSession,
    required this.timeOutInSeconds,
  });

  factory BookingSessionState.initial() => BookingSessionState(
        sessionStatus: Status.initial,
        bookingFailureSession: BookingSessionFailureModel.empty,
        bookingSuccessSession: BookingSessionSuccessModel.empty,
        timeOutInSeconds: 0,
      );

  @override
  List<Object> get props => [
        bookingFailureSession,
        bookingSuccessSession,
        sessionStatus,
        timeOutInSeconds,
      ];

  // copy with
  BookingSessionState copyWith({
    BookingSessionSuccessModel? bookingSuccessSession,
    BookingSessionFailureModel? bookingFailureSession,
    Status? sessionStatus,
    int? timeOutInSeconds,
  }) {
    return BookingSessionState(
      sessionStatus: sessionStatus ?? this.sessionStatus,
      bookingFailureSession:
          bookingFailureSession ?? this.bookingFailureSession,
      bookingSuccessSession:
          bookingSuccessSession ?? this.bookingSuccessSession,
      timeOutInSeconds: timeOutInSeconds ?? this.timeOutInSeconds,
    );
  }
}
