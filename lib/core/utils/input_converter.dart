import 'package:dartz/dartz.dart';

import '../errors/failure.dart';

class InputConverter {
  Either<Failure, int> stringToUnsignedInteger(String string) {
    try {
      final integer = int.parse(string);
      if (integer < 0) throw const FormatException();
      return Right(integer);
    } on FormatException {
      return const Left(InvalidInputFailure(properties: []));
    }
  }
}

class InvalidInputFailure extends Failure {
  const InvalidInputFailure({required List properties})
      : super(properties: properties);
}
