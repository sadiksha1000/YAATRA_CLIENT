import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../../../../core/errors/exception.dart';
import '../../../../../core/server/server.dart';
import '../../../../core/config/response_model.dart';
import '../../../../core/errors/failure.dart';
import '../models/user_model.dart';

abstract class UserRemoteDataSource {
  /// Calls the http://localhost:3001/user/login endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<UserModel> login(String phone, String password) {
    throw UnimplementedError();
  }

  /// Calls the http://localhost:3001/user/register endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<UserModel> registerUser(
      {required String phone, required String password}) {
    throw UnimplementedError();
  }

  /// Calls the http://<server>:<port>/api/v1/auth/logout endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  logout({required String uid});

  Future<int> sendOTPToPhone(String phone) {
    throw UnimplementedError();
  }

  loginUser({required String phone, required String password}) {}

  /// Calls the http://localhost:3001/user/getCurrentUser end point.
  ///
  /// Throws a [ServerException] for all error codes
  Future<UserModel> refreshCurrentUser({required String uid}) {
    throw UnimplementedError();
  }

  /// Calls the http://localhost:3001/user/switchRole end point.
  ///
  /// Throws a [ServerException] for all error codes
  Future<UserModel> switchUser(
      {required String uid, required String activeRole}) {
    throw UnimplementedError();
  }
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;

  UserRemoteDataSourceImpl({required this.client});

  @override
  Future<UserModel> registerUser(
      {required String phone, required String password}) async {
    var registerUrl = '$serverUrl/user/register';
    try {
      final response = await client.post(Uri.parse(registerUrl), body: {
        'phone': phone,
        'password': password,
        'isPassenger': "true",
        'isAgent': "false",
        'activeRole': 'passenger',
      });
      print(response);

      if (response.statusCode == 200) {
        var decodedResponse = ResponseModel.fromJson(response.body);
        return UserModel.fromMap(decodedResponse.data);
      } else {
        throw ServerFailure.fromJson(response.body);
      }
    } on SocketException {
      throw ServerFailure(
        properties: [],
        message:
            "There is some problem connecting with server, please try again later",
      );
    }
  }

  @override
  Future<int> sendOTPToPhone(String phone) async {
    return 123456;
  }

  @override
  Future<UserModel> switchUser(
      {required String uid, required String activeRole}) async {
    var loginUrl = '$serverUrl/user/switchRole';
    try {
      final response = await client.post(
        Uri.parse(loginUrl),
        body: {
          'uid': uid,
          'activeRole': activeRole,
        },
      );

      if (response.statusCode == 200) {
        var decodedResponse = ResponseModel.fromJson(response.body);
        return UserModel.fromMap(decodedResponse.data);
      } else {
        throw ServerFailure.fromJson(response.body);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel> loginUser(
      {required String phone, required String password}) async {
    var loginUrl = '$serverUrl/user/login';
    try {
      final response = await client.post(
        Uri.parse(loginUrl),
        body: {
          'phone': phone,
          'password': password,
        },
      );
      print(response.body);

      if (response.statusCode == 200) {
        var decodedResponse = ResponseModel.fromJson(response.body);
        return UserModel.fromMap(decodedResponse.data);
      } else {
        throw ServerFailure.fromJson(json.decode(response.body));
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  logout({required String uid}) async {
    var logoutUserUrl = '$serverUrl/user/logout';
    try {
      final response = await client.post(
        Uri.parse(logoutUserUrl),
        body: {
          'uid': uid,
        },
      );

      if (response.statusCode == 200) {
        return UserModel.empty;
      } else {
        throw ServerFailure.fromJson(response.body);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel> refreshCurrentUser({required String uid}) async {
    var activeUserRoleUrl = '$serverUrl/user/getCurrentUser';
    try {
      final response = await client.post(
        Uri.parse(activeUserRoleUrl),
        body: {
          'uid': uid,
        },
      );
      print(response);
      if (response.statusCode == 200) {
        var decodedResponse = ResponseModel.fromJson(response.body);
        return UserModel.fromMap(decodedResponse.data);
      } else {
        throw ServerFailure.fromJson(response.body);
      }
    } on ServerFailure catch (e) {
      throw ServerFailure(properties: [], message: e.message);
    }
  }

  @override
  Future<UserModel> login(String phone, String password) {
    // TODO: implement login
    throw UnimplementedError();
  }
}
