import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../../core/config/response_model.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/server/server.dart';
import '../../data/models/agent_model.dart';

abstract class ApplyAsAgentRemoteDataSource {
  /// Calls the http://localhost:3001/owner/apply end point.
  ///
  /// Throws a [ServerException] for all error codes
  Future<AgentModel> applyAsAgent({
    required String uid,
    required String name,
    required String phone,
    required String address,
    required List<String> documentUrl,
  }) async {
    throw UnimplementedError();
  }

  Future<AgentModel> refreshApplyAsAgent({
    required String aid,
  }) async {
    throw UnimplementedError();
  }
}

class ApplyAsAgentRemoteDataSourceImpl implements ApplyAsAgentRemoteDataSource {
  final http.Client client;

  ApplyAsAgentRemoteDataSourceImpl({required this.client});

  @override
  Future<AgentModel> applyAsAgent(
      {required String uid,
      required String name,
      required String phone,
      required String address,
      required List<String> documentUrl}) async {
    var applyAgentUrl = '$serverUrl/agent/apply';
    try {
      final response = await client.post(
        Uri.parse(applyAgentUrl),
        body: {
          'uid': uid,
          'phone': phone,
          'name': name,
          'address': address,
          'documentUrl': json.encode(documentUrl)
        },
      );

      if (response.statusCode == 201) {
        var decodedResponse = ResponseModel.fromJson(response.body);
        print("DecodedResponseData${decodedResponse.data}");
        return AgentModel.fromMap(decodedResponse.data);
      } else {
        throw ServerFailure.fromJson(response.body);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AgentModel> refreshApplyAsAgent({
    required String aid,
  }) async {
    var applyAgentUrl = '$serverUrl/agent/byId';
    try {
      final response = await client.post(
        Uri.parse(applyAgentUrl),
        body: {
          '_id': aid,
        },
      );

      if (response.statusCode == 200) {
        var decodedResponse = ResponseModel.fromJson(response.body);
        return AgentModel.fromMap(decodedResponse.data);
      } else {
        print("ResponseBody${response.body}");
        throw ServerFailure.fromJson(response.body);
      }
    } catch (e) {
      rethrow;
    }
  }
}
