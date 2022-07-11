import 'dart:convert';

import 'package:equatable/equatable.dart';

class ResponseModel extends Equatable {
  final String message;
  final bool success;
  final dynamic data;

  const ResponseModel({
    required this.message,
    required this.success,
    required this.data,
  });

  static const empty = ResponseModel(
    message: '',
    success: false,
    data: '',
  );

  bool get isEmpty => this == ResponseModel.empty;
  bool get isNotEmpty => this != ResponseModel.empty;

  @override
  List<Object?> get props => [
        message,
        success,
        data,
      ];

  // copy with
  ResponseModel copyWith({
    String? message,
    bool? success,
    String? data,
  }) {
    return ResponseModel(
        message: message ?? this.message,
        success: success ?? this.success,
        data: data ?? this.data);
  }

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'success': success,
      'data': data,
    };
  }

  factory ResponseModel.fromMap(Map<String, dynamic> map) {
    return ResponseModel(
      message: map['message'],
      success: map['success'],
      data: map['data'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponseModel.fromJson(String source) =>
      ResponseModel.fromMap(json.decode(source));
}
