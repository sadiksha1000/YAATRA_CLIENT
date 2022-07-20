import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:yaatra_client/core/errors/failure.dart';
import 'package:yaatra_client/features/passenger/booking/data/models/booking_session_failure_model.dart';
import 'package:yaatra_client/features/passenger/booking/data/models/booking_session_success_model.dart';

import '../../../../../core/config/response_model.dart';
import '../../../../../core/server/server.dart';

abstract class BookingRemoteDataSource {
  Future<BookingSessionSuccessModel> checkSeatAvailability(
      {required List<String> selectedSeats,
      required String tripId,
      required String userId}) {
    throw UnimplementedError();
  }

  Future<ResponseModel> createBooking(
      {required List<Map<String, String>> passengersDetails,
      required Map<String, String> contactDetails,
      required String tripId,
      required String userId,
      required String bookingSessionId,
      required int totalAmount}) {
    throw UnimplementedError();
  }
}

class BookingRemoteDataSourceImpl implements BookingRemoteDataSource {
  final http.Client client;

  BookingRemoteDataSourceImpl({
    required this.client,
  });

  @override
  Future<BookingSessionSuccessModel> checkSeatAvailability(
      {required List<String> selectedSeats,
      required String tripId,
      required String userId}) async {
    var sessionUrl = '$serverUrl/booking-session';

    var payload = {
      'tripId': tripId,
      'userId': userId,
      'selectedSeats': selectedSeats,
    };
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    print(payload);
    try {
      final response = await client.post(Uri.parse(sessionUrl),
          body: json.encode(payload), headers: headers);
      print("Fetch all sessions response.body: ${response.body}");
      if (response.statusCode == 200) {
        var decodedResponse = ResponseModel.fromJson(response.body);
        var data = decodedResponse.data;
        print("station data: $data");
        return BookingSessionSuccessModel.fromMap(data);
      } else {
        throw BookingSessionFailureModel.fromJson(json.decode(response.body));
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ResponseModel> createBooking({
    required List<Map<String, String>> passengersDetails,
    required Map<String, String> contactDetails,
    required String tripId,
    required String userId,
    required String bookingSessionId,
    required int totalAmount,
  }) async {
    var sessionUrl = '$serverUrl/booking';

    var payload = {
      'tripId': tripId,
      'userId': userId,
      'bookingSessionId': bookingSessionId,
      'passengersDetails': passengersDetails,
      'contactDetails': contactDetails,
      'totalAmount': totalAmount,
    };
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    print(payload);
    try {
      final response = await client.post(Uri.parse(sessionUrl),
          body: json.encode(payload), headers: headers);
      print("Fetch all sessions response.body: ${response.body}");
      if (response.statusCode == 200) {
        return ResponseModel.fromJson(response.body);
      } else {
        throw ServerFailure.fromJson(json.decode(response.body));
      }
    } catch (e) {
      rethrow;
    }
  }
}
