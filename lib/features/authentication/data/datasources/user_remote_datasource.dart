import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../../../core/errors/exception.dart';
import '../../../../../core/server/server.dart';
import '../../../../core/config/response_model.dart';
import '../../../../core/errors/failure.dart';
import '../models/user_model.dart';

abstract class UserRemoteDataSource {
  /// Calls the http://localhost:3001/user/register end point.
  ///
  /// Throws a [ServerException] for all error codes
  Future<UserModel> registerUser(
      {required String phone, required String password}) {
    throw UnimplementedError();
  }

  /// Calls the http://localhost:3001/user/login end point.
  ///
  /// Throws a [ServerException] for all error codes
  Future<UserModel> loginUser(
      {required String phone, required String password}) {
    throw UnimplementedError();
  }

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

  Future<int> sendOTPToPhone(String phone) {
    throw UnimplementedError();
  }

  logout({required String uid}) {}
}

// **************************************************************************
class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;

  UserRemoteDataSourceImpl({required this.client});
  @override
  Future<UserModel> registerUser(
      {required String phone, required String password}) async {
    var registerUrl = '$serverUrl/user/register';
    try {
      final response = await client.post(
        Uri.parse("$serverUrl/user/register"),
        body: {
          'phone': phone,
          'password': password,
          'isConductor': "false",
          'isPassenger': "true",
          'activeRole': 'passenger',
        },
      );

      if (response.statusCode == 201) {
        var decodedResponse = ResponseModel.fromJson(response.body);
        return UserModel.fromMap(decodedResponse.data,
            message: decodedResponse.message);
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

      debugPrint(response.body);
      if (response.statusCode == 200) {
        var decodedResponse = ResponseModel.fromJson(response.body);
        return UserModel.fromMap(decodedResponse.data,
            message: decodedResponse.message);
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
        return UserModel.fromMap(decodedResponse.data,
            message: decodedResponse.message);
      } else {
        throw ServerFailure.fromJson(response.body);
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
      if (response.statusCode == 200) {
        var decodedResponse = ResponseModel.fromJson(response.body);
        return UserModel.fromMap(decodedResponse.data,
            message: decodedResponse.message);
      } else {
        throw ServerFailure.fromJson(response.body);
      }
    } on ServerFailure catch (e) {
      throw ServerFailure(properties: [], message: e.message);
    }
  }
}
