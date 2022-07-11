import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../../../core/config/response_model.dart';
import '../../../../../core/errors/exception.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/server/server.dart';
import '../../../../authentication/data/models/user_model.dart';
import '../../domain/enities/passenger_profile.dart';
import '../models/passenger_profile_model.dart';

abstract class PassengerProfileRemoteDataSource {
  Future<PassengerProfileModel> createProfile(
      PassengerProfile passengerProfile) {
    throw UnimplementedError();
  }

  Future<PassengerProfileModel> fetchAllPassenger() {
    throw UnimplementedError();
  }

  Future<PassengerProfileModel> getCurrentPassenger({required String uid}) {
    throw UnimplementedError();
  }
}

class PassengerProfileRemoteDataSourceImpl
    implements PassengerProfileRemoteDataSource {
  final http.Client client;

  PassengerProfileRemoteDataSourceImpl({required this.client});

  @override
  Future<PassengerProfileModel> createProfile(
      PassengerProfile passengerProfile) async {
    var profileUrl =
        '$serverUrl/passenger'; // yaha register garne ke update garne ho '$serverUrl/passenger'
    var body = {
      '_id': passengerProfile.pId,
      'name': passengerProfile.name,
      'profileUrl': passengerProfile.profileUrl,
      'address': passengerProfile.address,
      'phone': passengerProfile.phone
    };
    print("Body in create profile $passengerProfile");
    print("Body in create profile $body");
    try {
      final response = await client.put(Uri.parse(profileUrl), body: body);
      if (response.statusCode == 200) {
        var decodedResponse = ResponseModel.fromJson(response.body);
        return PassengerProfileModel.fromMap(decodedResponse.data,
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
  Future<PassengerProfileModel> getCurrentPassenger(
      {required String uid}) async {
    var getPassengerUrl = '$serverUrl/passenger/byDetails';
    try {
      final response =
          await client.post(Uri.parse(getPassengerUrl), body: {"uid": uid});
      if (response.statusCode == 200) {
        var decodedResponse = ResponseModel.fromJson(response.body);
        var passenger = PassengerProfileModel.fromMap(
          decodedResponse.data,
          message: decodedResponse.message,
        );
        return passenger;
      } else {
        throw ServerFailure.fromJson(response.body);
      }
    } catch (e) {
      print("ERR :: " + e.toString());
      rethrow;
    }
  }

  @override
  Future<PassengerProfileModel> fetchAllPassenger() async {
    var getPassengerUrl = '$serverUrl/passenger';
    try {
      final response = await client.get(
        Uri.parse(getPassengerUrl),
      );
      if (response.statusCode == 200) {
        var decodedResponse = ResponseModel.fromJson(response.body);
        return decodedResponse.data
            .map((e) => PassengerProfileModel.fromMap(e,
                message: decodedResponse.message))
            .toList();
      } else {
        throw ServerFailure.fromJson(response.body);
      }
    } catch (e) {
      rethrow;
    }
  }

  // Future<UserModel> getCurrentUser({required String uid}) async {
  //   var getUserUrl = '$serverUrl/user/byId';
  //   try {
  //     final response = await client.get(Uri.parse(getUserUrl));
  //     if (response.statusCode == 200) {
  //       var decodedResponse = ResponseModel.fromJson(response.body);
  //       return decodedResponse.data.map((e) => UserModel.fromMap(e)).toList();
  //     } else {
  //       throw ServerFailure.fromJson(response.body);
  //     }
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

}
