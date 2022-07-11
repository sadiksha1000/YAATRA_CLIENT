import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/config/response_model.dart';
import '../../../../../core/errors/exception.dart';
import '../../../../../core/server/server.dart';
import '../../../../core/errors/failure.dart';
import '../../../trips/data/models/bus_model.dart';
import '../../../trips/data/models/station_model.dart';

abstract class BusRemoteDataSource {
  /// Calls the http://localhost:3001/bus/view endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<BusModel>> fetchAllBuses({
    required String sourceParams,
    required String destinationParams,
  }) {
    throw UnimplementedError();
  }

  fetchAllStations() {
    throw UnimplementedError();
  }
}

class BusRemoteDataSourceImpl implements BusRemoteDataSource {
  final http.Client client;

  BusRemoteDataSourceImpl({required this.client});

  @override
  Future<List<BusModel>> fetchAllBuses({
    required String sourceParams,
    required String destinationParams,
  }) async {
    var busUrl = '$serverUrl/bus/search';
    try {
      final response = await client.post(Uri.parse(busUrl), body: {
        'sourceParams': sourceParams,
        'destinationParams': destinationParams,
      });
      print("response.body: ${response.body}");
      if (response.statusCode == 200) {
        return (json.decode(response.body) as List)
            .map((bus) => BusModel.fromJson(bus))
            .toList();
      } else {
        throw ServerFailure.fromJson(json.decode(response.body));
      }
    } catch (e) {
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
        var data = decodedResponse.data as List<dynamic>;
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
}
