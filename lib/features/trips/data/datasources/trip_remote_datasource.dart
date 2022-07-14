import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/config/response_model.dart';
import '../../../../../core/errors/exception.dart';
import '../../../../../core/server/server.dart';
import '../../../../core/errors/failure.dart';
import '../models/station_model.dart';
import '../models/trip_model.dart';

abstract class TripRemoteDataSource {
  Future<List<dynamic>> fetchAllTrips({
    required String selectedFromStation,
    required String selectedtoStation,
    required DateTime selectedDate,
    required int seats,
  }) {
    throw UnimplementedError();
  }

  Future<TripModel> fetchTripById({required String id}) {
    throw UnimplementedError();
  }

  fetchAllStations() {
    throw UnimplementedError();
  }
}

class TripRemoteDataSourceImpl implements TripRemoteDataSource {
  final http.Client client;

  TripRemoteDataSourceImpl({
    required this.client,
  });

  @override
  Future<List<dynamic>> fetchAllTrips({
    required String selectedFromStation,
    required String selectedtoStation,
    required DateTime selectedDate,
    required int seats,
  }) async {
    var tripUrl = '$serverUrl/trip/search';
    try {
      final response = await client.post(Uri.parse(tripUrl), body: {
        'selectedFromStation': selectedFromStation,
        'selectedtoStation': selectedtoStation,
        'selectedDate': selectedDate.toIso8601String(),
        'seats': seats.toString(),
      });
      if (response.statusCode == 200) {
        var decodedResponse = ResponseModel.fromJson(response.body);
        var data = decodedResponse.data;
        var message = decodedResponse.message;

        List<dynamic> trips = [];
        data.forEach((trip) {
          print("Single trip in remote data source : $trip");
          trips.add(TripModel.fromMap(trip, message: decodedResponse.message));
        });

        print("All trip in remote data source : ${data}");
        return trips;
      } else {
        throw ServerFailure.fromJson(json.decode(response.body));
      }
    } catch (e) {
      print("ERR ::" + e.toString());
      rethrow;
    }
  }

  @override
  Future<List<StationModel>> fetchAllStations() async {
    var stationUrl = '$serverUrl/admin/station/';
    try {
      final response = await client.get(Uri.parse(stationUrl));
      print("Fetch all stations response.body: ${response.body}");
      if (response.statusCode == 200) {
        var decodedResponse = ResponseModel.fromJson(response.body);
        var data = decodedResponse.data;
        print("station data: $data");
        var stations = data
            .map((station) =>
                StationModel.fromMap(station, message: decodedResponse.message))
            .toList();
        return stations;
        // List<StationModel> stations =data.map((key, value) => null) as
        // return stations;
        // return (json.decode(response.body))
        //     .map((station) => StationModel.fromJson(station))
        //     .toList();
      } else {
        throw ServerFailure.fromJson(json.decode(response.body));
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<TripModel> fetchTripById({required String id}) async {
    var tripUrl = '$serverUrl/trip/byId';
    print('i was called here');
    try {
      final response = await client.post(Uri.parse(tripUrl), body: {
        '_id': id,
      });
      if (response.statusCode == 200) {
        var decodedResponse = ResponseModel.fromJson(response.body);

        return TripModel.fromMap(decodedResponse.data,
            message: decodedResponse.message);
      } else {
        throw ServerFailure.fromJson(json.decode(response.body));
      }
    } catch (e) {
      print("ERR ::" + e.toString());
      rethrow;
    }
  }
}
