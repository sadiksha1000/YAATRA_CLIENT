import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../../../../core/config/response_model.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/server/server.dart';
import '../models/booking_model.dart';

abstract class FetchTicketRemoteDataSource {
  Future<List<BookingModel>> fetchAllTickets({required String userId}) {
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
}
