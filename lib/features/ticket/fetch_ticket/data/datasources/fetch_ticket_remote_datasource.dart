import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:yaatra_client/features/trips/data/models/trip_model.dart';
import '../../../../../core/config/response_model.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/server/server.dart';
import '../../../../trips/domain/entities/trip.dart';
import '../models/booking_model.dart';

abstract class FetchTicketRemoteDataSource {
  Future<List<BookingModel>> fetchAllTickets({required String userId}) {
    throw UnimplementedError();
  }

  Future<TripModel> fetchTrip({required String tripId}) {
    throw UnimplementedError();
  }
}

class FetchTicketRemoteDataSourceImpl implements FetchTicketRemoteDataSource {
  final http.Client client;

  FetchTicketRemoteDataSourceImpl({
    required this.client,
  });

  @override
  Future<List<BookingModel>> fetchAllTickets({required String userId}) async {
    var bookingUrl = '$serverUrl/booking/byDetails';
    try {
      final response = await client.post(Uri.parse(bookingUrl), body: {
        'userId': userId,
      });
      if (response.statusCode == 200) {
        var decodedResponse = ResponseModel.fromJson(response.body);
        var data = decodedResponse.data;
        var message = decodedResponse.message;
        print("data: $data");
        print("Message: $message");
        List<BookingModel> bookings = [];
        data.forEach((booking) {
          bookings.add(
              BookingModel.fromMap(booking, message: decodedResponse.message));
        });
        print("Booking $bookings");
        return bookings;
      } else {
        throw ServerFailure.fromJson(json.decode(response.body));
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<TripModel> fetchTrip({required String tripId}) async {
    var tripUrl = '$serverUrl/trip/byId';
    try {
      final response = await client.post(Uri.parse(tripUrl), body: {
        '_id': tripId,
      });
      if (response.statusCode == 200) {
        var decodedResponse = ResponseModel.fromJson(response.body);
        var data = decodedResponse.data;
        var message = decodedResponse.message;
        TripModel trip = TripModel.fromMap(data, message: '');
        print("Trip $trip");
        return trip;
      } else {
        throw ServerFailure.fromJson(json.decode(response.body));
      }
    } catch (e) {
      rethrow;
    }
  }
}
