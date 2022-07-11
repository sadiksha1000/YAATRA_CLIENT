import 'dart:convert';

import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String? message;
  final bool? success;
  final List properties;
  const Failure({required this.properties, this.message, this.success});

  @override
  List<Object?> get props => [properties, message, success];
}

// General Failures
class CacheFailure extends Failure {
  CacheFailure({required List properties}) : super(properties: properties);
}

class ServerFailure extends Failure {
  final String? message;
  final bool? success;
  ServerFailure({required List properties, this.message, this.success})
      : super(properties: properties);

  factory ServerFailure.fromMap(Map<String, dynamic> map) {
    return ServerFailure(
      properties: [],
      message: map['message'],
      success: map['success'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'success': success,
    };
  }

  String toJson() => json.encode(toMap());

  factory ServerFailure.fromJson(String source) =>
      ServerFailure.fromMap(json.decode(source));
}
