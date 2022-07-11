class ServerException implements Exception {
  final String? message;
  final bool? success;
  ServerException({this.message, this.success});

  factory ServerException.fromJson(Map<String, dynamic> json) {
    return ServerException(message: json['message'], success: json['success']);
  }
}

class CacheException implements Exception {}
